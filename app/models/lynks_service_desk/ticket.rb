# == Schema Information
#
# Table name: lynks_service_desk_tickets
#
#  id              :integer          not null, primary key
#  sub_category_id :integer
#  creator_id      :integer
#  assignee_id     :integer
#  state           :string           not null
#  body            :json             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#


module LynksServiceDesk
  require 'aasm'

  class Ticket < ApplicationRecord
  	include AASM
    attr_accessor :state_transition, :user_id, *CONFIG.allowed_relation_objects_attributes
    before_save :apply_state_transition!
    after_save :save_relation_objects!
    default_scope -> () {order(created_at: :DESC)}
    belongs_to :sub_category
    has_many :metrics
    has_many :objects, class_name: "LynksServiceDesk::TicketRelationObject"
    delegate :category, to: :sub_category

    # just in case, i added the second condition, so as to not override the default state scope
    if CONFIG.unopened_using_metrics? && !self.respond_to?(:unopened)
      scope :unopened, -> () { where(state: CONFIG.initial_state_symbol)
                         .left_joins(:metrics)
                         .where(lynks_service_desk_metrics: {id: nil}) }
    end

    aasm :state, column: "state" do
      state CONFIG.initial_state_symbol, initial: true
      CONFIG.other_states.each{|state_symbol| state state_symbol}

      CONFIG.state_transitions_hash_for_aasm.each do |transition_hash|
        event transition_hash[:event_name] do
          transitions from: transition_hash[:from], to: transition_hash[:to] 
        end
      end
    end

    def apply_state_transition!
      state_transition_to_apply = state_transition
      self.state_transition = nil
      if state_transition_to_apply.present?
        self.send(state_transition_to_apply.to_s + "!")
        if CONFIG.save_state_transitions_metrics?
          self.metrics.create(user_id: self.user_id, action: state_transition_to_apply)
          self.user_id = nil
        end
      end
      self
    end

    def generate!(sub_category, sub_category_params)
      self.sub_category = sub_category
      self.body[:values] = {}
      sub_category_params.each do |key, value|
        self.body[:values][key] = value
      end
      self.body[:messages] = sub_category.options["messages"]
      self.body[:messages].each do |locale, message|
        subbed_message = message
        self.body[:values].each do |to_sub, value|
          self.body[:messages][locale] = subbed_message.gsub!("%"+to_sub.to_s, value.to_s)
        end
      end
      self.body[:objects] = {}
      self.save!
      self
    end

    def public_state
      if self.persisted? && CONFIG.unopened_using_metrics? && self.metrics.blank?
        return "unopened"
      else
        return self[:state]
      end
    end

    def available_state_transitions
      self.aasm(:state).events(:permitted => true).map(&:name)
    end

    def body
      if self[:body].nil?
        self[:body] = {}
      end
      self[:body]
    end

    def add_single_object(type, params)
      self.body["objects"] = self.body["objects"].to_h
      self.body["objects"][type.pluralize] = self.body["objects"][type.pluralize].to_a
      keys_to_look_for = CONFIG.allowed_ticket_objects[type.to_sym]
      if keys_to_look_for.blank?
        raise LynksServiceDesk::Exceptions::ObjectNotInConfig, "Could not find any parameters for #{type}. Is it defined in the config file ?"
      end
      object = {}
      keys_to_look_for.each do |key|
        value = params[key] || params[key.to_s] || params[key.to_sym]
        if value.blank?
          raise LynksServiceDesk::Exceptions::InvalidObject, "'#{key}' is missing"
        end
        object[key] = value
      end
      object[:created_at] = Time.zone.now
      self.body["objects"][type.pluralize] << object
      self.save!
   end

    def save_relation_objects!
      CONFIG.allowed_relation_objects_attributes.each do |attr_name|
        next if self.send(attr_name).blank?
        [self.send(attr_name)].flatten.uniq.each do |id|
          self.objects.create!(
            relation_object_id: id,
            relation_object_type: attr_name.split("_id")[0].camelize
          )
        end
      end
    end

  end
end

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

    attr_accessor :state_transition, :user_id
    before_save :apply_state_transition!

    belongs_to :sub_category
    has_many :metrics
    delegate :category, to: :sub_category

    # just in case, i added the second condition, so as to not override the default state scope
    if Formatter.unopened_using_metrics? && !self.respond_to?(:unopened)
      scope :unopened, -> () { where(state: Formatter.initial_state_symbol)
                         .left_joins(:metrics)
                         .where(lynks_service_desk_metrics: {id: nil}) }
    end

    aasm :state, column: "state" do
      state Formatter.initial_state_symbol, initial: true
      Formatter.other_states.each{|state_symbol| state state_symbol}

      Formatter.state_transitions_hash_for_aasm.each do |transition_hash|
        event transition_hash[:event_name] do
          transitions from: transition_hash[:from], to: transition_hash[:to] 
        end
      end
    end

    def apply_state_transition!
      if state_transition.present?
        self.send(state_transition.to_s + "!")
        if Formatter.save_state_transitions_metrics?
          self.metrics.create(user_id: self.user_id, action: self.state_transition)
        end
      end

      self
    end

  end
end

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
    belongs_to :sub_category
    has_many :metrics
    delegate :category, to: :sub_category

    if Formatter.new_using_metrics?
      scope :new, -> () { where(state: Formatter.initial_state_symbol)
                         .join(:metrics)
                         .where(metrics: nil)}
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

  end
end

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

require 'aasm'

module LynksServiceDesk
  class Ticket < ApplicationRecord
  	include AASM
    belongs_to :sub_category
    delegate :category, to: :sub_category, allow_nil: true

    aasm :state, column: "state" do
      state :open, initial: true
    end

  end
end

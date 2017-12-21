# == Schema Information
#
# Table name: lynks_service_desk_ticket_objects
#
#  id         :integer          not null, primary key
#  ticket_id  :integer
#  type       :string
#  body       :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module LynksServiceDesk
  class TicketObject < ApplicationRecord
    belongs_to :ticket
  end
end

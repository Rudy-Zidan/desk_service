# == Schema Information
#
# Table name: lynks_service_desk_ticket_relation_objects
#
#  id                   :integer          not null, primary key
#  ticket_id            :integer
#  relation_object_id   :integer
#  relation_object_type :string
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

module LynksServiceDesk
  class TicketRelationObject < ApplicationRecord
    belongs_to :ticket
  end
end

# == Schema Information
#
# Table name: lynks_service_desk_ticket_relation_objects
#
#  id                   :integer          not null, primary key
#  ticket_id            :integer
#  relation_object_id   :integer          not null
#  relation_object_type :string           not null
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

require 'test_helper'

module LynksServiceDesk
  class TicketRelationObjectTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end

# == Schema Information
#
# Table name: lynks_service_desk_tickets
#
#  id              :integer          not null, primary key
#  category_id     :integer
#  sub_category_id :integer
#  creator_id      :integer
#  assignee_id     :integer
#  state           :string           not null
#  body            :json             not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'test_helper'

module LynksServiceDesk
  class TicketTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end

# == Schema Information
#
# Table name: lynks_service_desk_metrics
#
#  id                       :integer          not null, primary key
#  ticket_id                :integer
#  user_id                  :integer
#  action                   :string           not null
#  duration_from_previous   :integer          not null
#  duration_from_created_at :integer          not null
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#

require 'test_helper'

module LynksServiceDesk
  class MetricTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end

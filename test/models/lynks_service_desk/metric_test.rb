# == Schema Information
#
# Table name: lynks_service_desk_metrics
#
#  id                       :integer          not null, primary key
#  ticket_id                :integer
#  action                   :string           not null
#  duration_from_previous   :string           not null
#  duration                 :string           not null
#  duration_from_created_at :string           not null
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

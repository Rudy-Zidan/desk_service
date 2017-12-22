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

module LynksServiceDesk
  class Metric < ApplicationRecord
    belongs_to :ticket
    default_scope { order("created_at ASC") }
    before_validation :populate_durations
  end
end

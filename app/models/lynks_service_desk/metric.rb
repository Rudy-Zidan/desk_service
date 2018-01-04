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
    default_scope { order(created_at: :asc) }
    before_validation :populate_durations
    validate :metric_allowed?

    def populate_durations

      duration_from_creation = Time.zone.now - self.ticket.created_at
      if self.ticket.metrics.exists?
        self[:duration_from_previous] = Time.zone.now - self.ticket.metrics.last.created_at.to_i
      else
        self[:duration_from_previous] = duration_from_creation
      end
      self[:duration_from_created_at] = duration_from_creation

      self
    end

    def metric_allowed?
      allowed = self.ticket.aasm(:state).events.map(&:name) + CONFIG.allowed_metrics
      allowed.include?(self.action.to_s.to_sym)
    end

  end
end

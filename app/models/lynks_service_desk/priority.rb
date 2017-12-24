# == Schema Information
#
# Table name: lynks_service_desk_priorities
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  slug       :string           not null
#  hours      :integer          default(24), not null
#  active     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

module LynksServiceDesk
  class Priority < ApplicationRecord
    before_validation :set_slug

    def set_slug
      self[:slug] = name.parameterize.underscore
    end

    def hours
      self[:hours].hours
    end

  end
end

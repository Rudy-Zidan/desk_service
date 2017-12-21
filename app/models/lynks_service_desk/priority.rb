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
    before_save :set_slug

    def set_slug
      slug = slug.parameterize
    end


  end
end

# == Schema Information
#
# Table name: lynks_service_desk_sub_categories
#
#  id          :integer          not null, primary key
#  category_id :integer
#  priority_id :integer
#  name        :string           default(""), not null
#  slug        :string           default(""), not null
#  active      :boolean          default(TRUE), not null
#  options     :json             not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

module LynksServiceDesk
  class SubCategory < ApplicationRecord
    belongs_to :category
    belongs_to :priority
    has_many :tickets

  end
end

# == Schema Information
#
# Table name: lynks_service_desk_categories
#
#  id         :integer          not null, primary key
#  name       :string           default(""), not null
#  slug       :string           default(""), not null
#  active     :boolean          default(TRUE), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

module LynksServiceDesk
  class CategoryTest < ActiveSupport::TestCase
    # test "the truth" do
    #   assert true
    # end
  end
end

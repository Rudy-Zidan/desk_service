# == Schema Information
#
# Table name: lynks_service_desk_tickets
#
#  id              :integer          not null, primary key
#  category_id     :integer
#  sub_category_id :integer
#  creator_id      :integer
#  assignee_id     :integer
#  state           :string
#  body            :json
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module LynksServiceDesk
  class Ticket < ApplicationRecord
    belongs_to :category
    belongs_to :sub_category
  end
end

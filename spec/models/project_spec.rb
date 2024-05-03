# == Schema Information
#
# Table name: projects
#
#  id          :bigint           not null, primary key
#  title       :string
#  description :text
#  start_date  :date
#  end_date    :date
#  budget      :bigint
#  manager_id  :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  type        :string
#  status      :integer          default("upcoming"), not null
#  published   :boolean          default(FALSE), not null
#  social_id   :bigint
#
require 'rails_helper'

RSpec.describe Project, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end

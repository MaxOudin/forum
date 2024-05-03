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
FactoryBot.define do
  factory :project do
    title { "MyString" }
    description { "MyText" }
    start_date { "2024-04-21" }
    end_date { "2024-04-21" }
    budget { "" }
    manager_id { "" }
    status { 2 }
  end
end

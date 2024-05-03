# == Schema Information
#
# Table name: organisme_projects
#
#  id                     :bigint           not null, primary key
#  type                   :string
#  organisme_id           :bigint           not null
#  project_id             :bigint           not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  org_project_manager_id :bigint
#  budget                 :bigint           default(0)
#
FactoryBot.define do
  factory :organisme_project do
    type { "" }
    organisme { nil }
    project { nil }
  end
end

# == Schema Information
#
# Table name: permissions
#
#  id          :bigint           not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
FactoryBot.define do
  factory :permission do
    name { "Utilisateur non connecté" }
    description { "Ne peut pas accéder à la plateforme" }
  end
end

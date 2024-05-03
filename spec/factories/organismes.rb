# == Schema Information
#
# Table name: organismes
#
#  id             :bigint           not null, primary key
#  name           :string
#  description    :text
#  type           :string
#  org_manager_id :bigint           not null
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
FactoryBot.define do
  factory :organisme do
    sequence(:name) { |n| "AFD BOT #{n}" }
    description { "Le groupe AFD, constitué de l'AFD, de sa filiale dédiée au secteur privé Proparco et de l'agence interministérielle de coopération technique Expertise France, accompagne de nombreux projets qui améliorent concrètement le quotidien des populations dans les territoires d’outre-mer français et dans un grand nombre de pays du monde à revenus faibles et intermédiaires. BOT" }
    type { "InstitutionUe" }
    association :user
    association :social
  end
end

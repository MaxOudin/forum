# == Schema Information
#
# Table name: events
#
#  id         :bigint           not null, primary key
#  type       :string
#  params     :json
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :event do
    # Ajoutez ici les attributs nécessaires à votre factory Event
    type { "Event type" }
    params { { key: "value" } }
  end
end

FactoryBot.define do
  factory :event do
    # Ajoutez ici les attributs nécessaires à votre factory Event
    type { "Event type" }
    params { { key: "value" } }
  end
end

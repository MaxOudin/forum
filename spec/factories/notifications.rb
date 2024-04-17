FactoryBot.define do
  factory :notification do
    # Ajoutez ici les attributs nécessaires à votre factory Notification
    event { association(:event) }
    association :recipient, factory: :user # Associe la notification à un utilisateur spécifique

  end
end

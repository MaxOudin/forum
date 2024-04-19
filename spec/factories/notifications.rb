# == Schema Information
#
# Table name: notifications
#
#  id            :bigint           not null, primary key
#  type          :string
#  event_id      :bigint           not null
#  recipent_type :string           not null
#  recipent_id   :bigint           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
FactoryBot.define do
  factory :notification do
    # Ajoutez ici les attributs nécessaires à votre factory Notification
    event { association(:event) }
    association :recipient, factory: :user # Associe la notification à un utilisateur spécifique

  end
end

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  admin                  :boolean          default(FALSE)
#  permission_id          :bigint
#
FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:email) { |n| "j.doe+#{n}@email.com" }
    password { 'password' }
    admin { false }
    created_at { Time.now }
    updated_at { Time.now }

    trait :with_short_password do
      password { '12345' }
    end

    trait :admin do
      admin { true }
    end

    association :permission

    # Créer des notifications pour cet utilisateur
    transient do
      notifications_count { 3 } # Définir le nombre de notifications que vous voulez créer
    end
  end
end

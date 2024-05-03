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
#  role                   :integer          default("admin_ue"), not null
#
FactoryBot.define do
  factory :user do
    sequence(:id) { |n| n }
    sequence(:email) { |n| "j.doe+#{n}@email.com" }
    password { 'password' }
    admin { false }
    created_at { Time.now }
    updated_at { Time.now }
    role { :user }

    trait :with_short_password do
      password { '12345' }
    end

    trait :admin_all do
      admin { true }
      role { :admin_ue }
    end

    trait :admin do
      admin { true }
    end

    trait :program_manager do
      role { :program_manager }
    end

    trait :admin_ue do
      role { :admin_ue }
    end

    trait :coop_head do
      role { :coop_head }
    end

    trait :tei_manager do
      role { :tei_manager }
    end

    trait :pub_editor do
      role { :publication_editor }
    end
    # association :permission

    # Créer des notifications pour cet utilisateur
    transient do
      notifications_count { 3 } # Définir le nombre de notifications que vous voulez créer
    end
  end
end

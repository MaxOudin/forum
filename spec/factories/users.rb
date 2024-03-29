FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "j.doe+#{n}@email.com" }
    password { 'password' }
    admin { false }

    trait :with_short_password do
      password { '12345' }
    end

    trait :admin do
      admin { true }
    end
  end
end

user = FactoryBot.build(:user) # Crée un utilisateur standard
admin = FactoryBot.build(:user, :admin) # Crée un administrateur
user_with_short_password = FactoryBot.build(:user, :with_short_password) # Crée un utilisateur avec un mot de passe trop court


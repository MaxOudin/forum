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
  end
end

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "j.doe+#{n}@email.com" }
    password { 'password' }
    admin { false }
  end

  factory :admin, class: User do
    sequence(:email) { |i| "admin+#{i}@email.com" }
    password { "password" }
    admin { true }
  end
end

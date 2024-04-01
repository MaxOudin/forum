FactoryBot.define do
  factory :article do
    sequence(:id) { |n| n }
    title { "Sample Article" }
    content { "Sample Content" }
    public { true }
    user { association(:user) }

  end
end

FactoryBot.define do
  factory :article do
    title { "Sample Article" }
    content { "Sample Content" }
    user { association(:user) }

  end
end

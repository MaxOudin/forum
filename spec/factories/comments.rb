FactoryBot.define do
  factory :comment do
    content { "MyText" }
    article { nil }
  end
end

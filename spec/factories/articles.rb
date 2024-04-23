# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint
#  public     :boolean          default(FALSE)
#
FactoryBot.define do
  factory :article do
    sequence(:id) { |n| n }
    title { "Sample Article" }
    content { "Sample Content" }
    public { true }
    user { association(:user) }

  end
end

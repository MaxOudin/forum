# == Schema Information
#
# Table name: socials
#
#  id                 :bigint           not null, primary key
#  youtube_channel    :string
#  youtube_video_url  :string
#  x_twitter          :string
#  facebook_page_url  :string
#  linkedin_page_url  :string
#  instagram_page_url :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  name               :string
#  website_url        :string
#
FactoryBot.define do
  factory :social do
    youtube_channel { "https://www.youtube.com/@GroupeAFD" }
    youtube_video_url { "https://www.youtube.com/watch?v=Uj6XHM4xw7o&list=PLWs6yE3bJ-3j2ZJl7gPJCtCFVfvXvNsuF" }
    x_twitter { "https://twitter.com/AFD_France" }
    facebook_page_url { "https://www.facebook.com/AFDOfficiel/" }
    linkedin_page_url { "https://www.linkedin.com/company/agence-francaise-de-developpement/" }
    instagram_page_url { "https://www.instagram.com/afd_france/" }
  end
end

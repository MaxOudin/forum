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
#  socialable_type    :string           not null
#  socialable_id      :bigint           not null
#
require 'rails_helper'

RSpec.describe Social, type: :model do
  
end

class CreateSocials < ActiveRecord::Migration[7.1]
  def change
    create_table :socials do |t|
      t.string :youtube_channel
      t.string :youtube_video_url
      t.string :x_twitter
      t.string :facebook_page_url
      t.string :linkedin_page_url
      t.string :instagram_page_url

      t.timestamps
    end
  end
end

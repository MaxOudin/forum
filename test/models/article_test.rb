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
require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  
  # test "the truth" do
  #   assert true
  # setup
  # exercise
  # verify
  # teardown
  # end
end

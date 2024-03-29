require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  test "visiting the homepage" do
    # setup

    # exercise
    visit root_url # "/"

    # verify
    assert_selector "h2", text: "Forum"

    # teardown

  end

  test "visiting the index" do
    visit root_url
    assert_selector "h2", text: "Forum"
    assert_selector ".card-body", count: Article.count
  end
end

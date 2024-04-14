class NewArticleNotifier < Event

  def message
    "Hey ! Il existe un nouveau article sur la plateforme !"
  end

  def url
    article_url
  end

end

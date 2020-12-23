class Scraper

  def self.scrape_new_articles(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    stories = doc.css("div.item-info-wrap")
    stories.each do |story|
      title = story.css("h1").text
      description = story.css("p").text
      if story.css("a").attribute("href").value.start_with?("http")
        url = story.css("a").attribute("href").value
      else
        url = "https://www.espn.com#{story.css("a").attribute("href").value}"
      end
      Article.new(title, description, url)
    end
    Article.all
  end

  def self.scrape_new_nhl_articles(url)
    html = open(url)
    doc = Nokogiri::HTML(html)
    stories = doc.css("article").select{|story| story.css('a.contentItem__content').attribute('href')}
    stories.each do |story|
      title = story.css("h2.contentItem__title").text
      description = nil
      if story.css('a.contentItem__content').attribute('href').value.start_with?("http")
        url = story.css('a.contentItem__content').attribute('href').value
      else
        url = "https://www.espn.com#{story.css('a.contentItem__content').attribute('href').value}"
      end
      Article.new(title, description, url)
    end
    Article.all
  end

  def self.get_content(article)
    html = open(article.url)
    doc = Nokogiri::HTML(html)
    #for ESPN Radio links, this will return an empty array
    article.content = doc.css("div.article-body p")
    article.content = doc.css("div.Story__Body p") if article.content.size == 0
  end

end

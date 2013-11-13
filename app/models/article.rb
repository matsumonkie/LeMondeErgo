require 'nokogiri'

class Article

  attr_reader :title
  attr_reader :link
  attr_reader :desc
  attr_reader :img

  def initialize(title, desc, link, img)
    @title = title
    @desc = desc
    @link = link
    @img = img
  end
  
  def self.getMainArticleFromDOM(dom)
    title = dom.css("h2").text
    desc =  dom.css("p").text

    img = ""
    dom.css("img").each do |i|
      img = i['data-src']    
    end

    link = ""
    dom.css("a").each do |a|
      link = a['href']
    end

    link = addWebsiteURLIfMissing(link)
    
    return Article.new(title, desc, link, img)
  end

  def self.getArticlesFromDom(dom)
    articles = []
    
    titles = []
    dom.css("figcaption").each do |t|
      titles.push(t.text)
    end
          
    links = []
    dom.css("a").each do |l|
      link = l['href']
      link = addWebsiteURLIfMissing(link)      
      links.push(link)
    end

    titles.zip(links) do |title, link|
      articles.push(Article.new(title, desc = "", link, img = ""))
    end

    return articles  
  end

  private

  def self.addWebsiteURLIfMissing(url)
    url = if (url.start_with?("/"))
      LeMondeErgo::Application::LE_MONDE_SITE_URL + url
    else
      url
    end
    
    return url
  end  
  
end

require 'nokogiri'

class Article

  attr_reader :title
  attr_reader :link
  attr_reader :desc

  def initialize(title, desc, link)
    @title = title
    @desc = desc
    @link = link
  end

  def self.getMainArticleFromDOM(dom)
    title = dom.css("h2").text
    desc =  dom.css("p").text
    link = ""
    return Article.new(title, desc, link)
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
      link = if (link.start_with?("/"))
               LeMondeErgo::Application::LE_MONDE_SITE_URL + link
             else
               link
             end
      
      links.push(link)
    end

    titles.zip(links) do |title, link|
      articles.push(Article.new(title, desc = "", link))
    end

    return articles  
  end
  
end

require 'nokogiri'

class Article

  attr_reader :title, :desc, :link, :img

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

    link = Util.addWebsiteURLIfMissing(link)
    
    Article.new(title, desc, link, img)
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
      link = Util.addWebsiteURLIfMissing(link)      
      links.push(link)
    end

    images = []
    dom.css("img").each do |i|
      images.push(i['data-src'])
    end

    titles.zip(links, images) do |title, link, image|
      articles.push(Article.new(title, desc = "", link, image))
    end

    articles
  end
  
end

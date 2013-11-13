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

    images = []
    dom.css("img").each do |i|
      images.push(i['data-src'])
    end

    titles.zip(links, images) do |title, link, image|
      articles.push(Article.new(title, desc = "", link, image))
    end

    return joinArrayByPair(articles)
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

  # [1,2,3,4] should become [[1,2], [3,4]]
  def self.joinArrayByPair(array)
    return array.each_slice(2).to_a
  end
  
end

require 'nokogiri'

class Premiere

  CSS_QUERY_FOR_COUVERTURE = "article.titre_une"

  attr_reader :couverture, :articles

  Couverture = Struct.new(:title, :image, :desc, :link, :links)
  
  def initialize(couverture, articles)
    @couverture = couverture
    @articles = articles
  end

  def self.last(dom)
    couverture = getCouvertureFromDom(dom)
    return Premiere.new(couverture, "")
  end

  def self.getCouvertureFromDom(dom)
    couverture = dom.css(CSS_QUERY_FOR_COUVERTURE)

    title = couverture.css("h1").text

    image = ""
    couverture.css("img").each do |i|
      image = i['src']
    end

    desc = couverture.css(".description").text
    link = ""
    couverture.css("a").each do |l|
      link = l['href']  
    end

    links = ""
    
    return Couverture.new(title, image, desc, link, links)
  end

end

require 'nokogiri'

class Premiere

  CSS_QUERY_FOR_COUVERTURE = ".titres_edito"

  attr_reader :couverture, :articles

  Couverture = Struct.new(:title, :image, :desc, :link, :links)
  Link = Struct.new(:text, :link)
  
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

    title = couverture.at_css("h1").text
    image = couverture.at_css(".titre_une img")['src']
    desc = couverture.at_css(".titre_une .description").text
    link = couverture.at_css(".titre_une a")['href']  

    links = []
    couverture.css(".liste_une a").each do |l|      
      links.push(Link.new(l.text, l['href']))
    end

    return Couverture.new(title, image, desc, link, links)
  end

end

require 'nokogiri'

class Premiere

  CSS_QUERY_FOR_COUVERTURE = ".titres_edito"
  CSS_QUERY_FOR_SECOND_ARTICLES = ".titres_hauts"

  attr_reader :couverture, :secondary_articles

  Couverture = Struct.new(:title, :image, :desc, :link, :links)
  Link = Struct.new(:text, :link)
  
  def initialize(couverture, secondary_articles)
    @couverture = couverture
    @secondary_articles = secondary_articles
  end

  def self.last(dom)
    couverture = getCouvertureFromDom(dom.css(CSS_QUERY_FOR_COUVERTURE))
    secondaryArticles = getSecondaryArticlesFromDom(dom.css(CSS_QUERY_FOR_SECOND_ARTICLES))
    return Premiere.new(couverture, secondaryArticles)
  end

  def self.getCouvertureFromDom(dom)
    title = dom.at_css("h1").text
    image = dom.at_css(".titre_une img")['src']
    desc = dom.at_css(".titre_une .description").text
    link = dom.at_css(".titre_une a")['href']  

    links = []
    dom.css(".liste_une a").each do |l|      
      links.push(Link.new(l.text, l['href']))
    end

    return Couverture.new(title, image, desc, link, links)
  end

  def self.getSecondaryArticlesFromDom(dom)
    articles = []
    descriptions = dom.css("article > p")
    images = dom.css("article > a > img")
    titlesAndLinks = dom.css("article > a")
    titlesAndLinks.zip(descriptions).each do |a, d|
      articles.push(Article.new(a.text, d.text, a['href'], ""))
    end
    
    return articles
  end

end

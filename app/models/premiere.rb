require 'nokogiri'

class Premiere

  CSS_QUERY_FOR_SECOND_ARTICLES = ".titres_hauts"

  attr_reader :couverture, :secondary_articles

  Couverture = Struct.new(:title, :image, :desc, :link, :links)
  Link = Struct.new(:text, :link)
  
  def initialize(couverture, secondary_articles)
    @couverture = couverture
    @secondary_articles = secondary_articles
  end

  def self.last(dom)
    couverture = getCouvertureFromDom(dom)
    secondaryArticles = getSecondaryArticlesFromDom(dom.css(CSS_QUERY_FOR_SECOND_ARTICLES))
    Premiere.new(couverture, secondaryArticles)
  end

  def self.getCouvertureFromDom(dom)
    debugger
    title = dom.at_css("h1").text
    image = dom.at_css(".titre_une img")["src"]
    desc = dom.at_css(".titre_une .description").text
    link = dom.at_css(".titre_une a")['href']
    link = Util.addWebsiteURLIfMissing(link)

    links = []
    dom.css(".liste_une a").each do |l|         
      links.push(Link.new(l.text, Util.addWebsiteURLIfMissing(l['href'])))
    end

    Couverture.new(title, image, desc, link, links)
  end

  def self.getSecondaryArticlesFromDom(dom)
    descriptions = dom.css("article > p")
    images = dom.css("article > a img")
    titlesAndLinks = dom.css("article > a")

    articles = []
    titlesAndLinks.zip(descriptions, images).each do |a, d, i|
      link = a['href']
      link = Util.addWebsiteURLIfMissing(link)
      articles.push(Article.new(a.text, d.text, link, i['src']))
    end
    
    articles
  end

end

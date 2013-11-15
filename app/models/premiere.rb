require 'nokogiri'

class Premiere

  CSS_QUERY_FOR_SECTIONS = "html body section.global.bord_rubrique.bordt3.deroule_edito:not(.promo)"
  CSS_QUERY_FOR_HEADER = "header h1 a"
  CSS_QUERY_FOR_MAIN_ARTICLE_CONTAINER = "article"
  CSS_QUERY_FOR_ARTICLES_CONTAINER = ".container .grid_12 .grid_6"

  attr_reader :couverture, :articles

  Couverture = Struct.new(:title, :image)
  
  def initialize(couverture, articles)
    @couverture = couverture
    @articles = articles
  end

  def self.last(dom)
    raw_sections = getSectionsFromLeMonde(dom)

    return Premiere.new(Couverture.new("haha", "hehe"), "houhou")
  end

  def self.formatSection(domSection)
    header = domSection.css(CSS_QUERY_FOR_HEADER).text

    article_container = domSection.css(CSS_QUERY_FOR_MAIN_ARTICLE_CONTAINER)
    main_article = Article.getMainArticleFromDOM(article_container)

    articles_container = domSection.css(CSS_QUERY_FOR_ARTICLES_CONTAINER)
    articles = Article.getArticlesFromDom(articles_container)
    
    return Section.new(header, main_article, articles)
  end

  def self.getSectionsFromLeMonde(dom)
    sections = []
    dom.css(CSS_QUERY_FOR_SECTIONS).each do |s|
      sections.push(s)
    end

    return sections
  end

end

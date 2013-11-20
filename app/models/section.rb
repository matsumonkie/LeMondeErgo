require 'nokogiri'

class Section

  CSS_QUERY_FOR_SECTIONS = "html body section.global.bord_rubrique.bordt3.deroule_edito:not(.promo)"
  CSS_QUERY_FOR_HEADER = "header h1 a"
  CSS_QUERY_FOR_MAIN_ARTICLE_CONTAINER = "article"
  CSS_QUERY_FOR_ARTICLES_CONTAINER = ".grid_6.liste_img_lien"

  attr_reader :header, :main_article, :articles
  
  def initialize(header, main_article, articles)
    @header = header
    @main_article = main_article
    @articles = articles
  end

  def self.lasts(dom)
    raw_sections = getSectionsFromLeMonde(dom)

    sections = []
    raw_sections.each do |s|
      sections.push(formatSection(s))
    end

    sections
  end

  def self.formatSection(domSection)
    header = domSection.css(CSS_QUERY_FOR_HEADER).text

    article_container = domSection.css(CSS_QUERY_FOR_MAIN_ARTICLE_CONTAINER)
    main_article = Article.getMainArticleFromDOM(article_container)

    articles_container = domSection.css(CSS_QUERY_FOR_ARTICLES_CONTAINER)
    articles = Article.getArticlesFromDom(articles_container)
    
    Section.new(header, main_article, articles)
  end

  def self.getSectionsFromLeMonde(dom)
    sections = []
    dom.css(CSS_QUERY_FOR_SECTIONS).each do |s|
      sections.push(s)
    end

    sections
  end

end

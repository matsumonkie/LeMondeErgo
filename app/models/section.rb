require 'nokogiri'
require 'open-uri'

class Section

  CSS_QUERY_FOR_SECTIONS = "html body section.global.bord_rubrique.bordt3.deroule_edito"
  CSS_QUERY_FOR_HEADER = "header h1 a"
  CSS_QUERY_FOR_ARTICLES_CONTAINER = ".container .grid_12 .grid_6"
  CSS_QUERY_FOR_MAIN_ARTICLE_CONTAINER = "article"

  attr_reader :header
  attr_reader :main_article
  attr_reader :articles

  def initialize(header, main_article, articles)
    @header = header
    @main_article = main_article
    @articles = articles
  end

  def self.lasts
    raw_sections = getSectionsFromLeMonde

    sections = []
    raw_sections.each do |s|
      sections.push(formatSection(s))
    end

    return sections
  end

  def self.formatSection(domSection)
    header = domSection.css(CSS_QUERY_FOR_HEADER).text

    article_container = domSection.css(CSS_QUERY_FOR_MAIN_ARTICLE_CONTAINER)
    main_article = Article.getMainArticleFromDOM(article_container)

    articles_container = domSection.css(CSS_QUERY_FOR_ARTICLES_CONTAINER)
    articles = Article.getArticlesFromDom(articles_container)
    
    return Section.new(header, main_article, articles)
  end

  def self.getSectionsFromLeMonde
    html = Nokogiri::HTML(open(LeMondeErgo::Application::LE_MONDE_SITE_URL))
    sections = []
    html.css(CSS_QUERY_FOR_SECTIONS).each do |s|
      sections.push(s)
    end

    return sections
  end

end

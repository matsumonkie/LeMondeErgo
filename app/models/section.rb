class Section

  WEBSITE_URL = "http://www.lemonde.fr/"                                   
  CSS_QUERY_FOR_SECTIONS = "html body section.global.bord_rubrique.bordt3.deroule_edito"

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
    sections = formatSections(raw_sections)
    return sections
  end

  def self.formatSections(htmlSections)
    sections = []
    htmlSections.each do |s|
      sections.push(formatSection(s))
    end
    return sections
  end
  
  def self.formatSection(htmlSection)
    header = htmlSection.css("header h1 a").text
    section = Section.new(header, header, header)
  end

  def self.getSectionsFromLeMonde
    html = Nokogiri::HTML(open(WEBSITE_URL))
    sections = []
    html.css(CSS_QUERY_FOR_SECTIONS).each do |s|
      sections.push(s)
    end

    return sections
  end

end

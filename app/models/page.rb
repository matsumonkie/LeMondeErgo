require 'open-uri'
require 'nokogiri'

class Page

  CSS_QUERY_FOR_PREMIERE = ".titres_edito"

  attr_reader :premiere, :sectionsAndColors
  
  def initialize(premiere, sections)
    @premiere = premiere
    @sectionsAndColors = sections.zip(Color.all)    
  end
  
  def self.last
    dom = getLeMondeMockHTML
#    dom = getLeMondeHTML
    premiere = Premiere.last(dom.css(CSS_QUERY_FOR_PREMIERE))
    sections = Section.lasts(dom)

    return Page.new(premiere, sections)
  end

  def self.getLeMondeHTML
    dom = Nokogiri::HTML(open(LeMondeErgo::Application::LE_MONDE_SITE_URL))
    dom.search(".nb_reactions").remove
    return dom
  end

  def self.getLeMondeMockHTML
     dom = Nokogiri::HTML(File.open("test/models/lemonde_mock.html"))
     dom.search(".nb_reactions").remove
     return dom
  end
  
end

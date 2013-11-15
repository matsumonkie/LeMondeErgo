require 'open-uri'
require 'nokogiri'

class Page

  attr_reader :premiere, :sectionsAndColors
  
  def initialize(premiere, sections)
    @premiere = premiere
    @sectionsAndColors = sections.zip(Color.all)    
  end
  
  def self.last
    dom = getLeMondeMockHTML
    premiere = Premiere.last(dom)
    sections = Section.lasts(dom)

    return Page.new(premiere, sections)
  end

  def self.getLeMondeHTML
    return Nokogiri::HTML(open(LeMondeErgo::Application::LE_MONDE_SITE_URL))
  end

  def self.getLeMondeMockHTML
     return Nokogiri::HTML(File.open("test/models/lemonde_mock.html"))
  end
  
end

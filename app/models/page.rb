class Page

  attr_reader :premiere, :sectionsAndColors
  
  def initialize(premiere, sections)
    @premiere = premiere
    @sectionsAndColors = sections.zip(Color.all)    
  end
  
  def self.last
    return Page.new("coucou", Section.lasts)
  end

end

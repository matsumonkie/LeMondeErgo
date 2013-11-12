class Article

  attr_reader :title
  attr_reader :link
  attr_reader :desc

  def initialize(title, desc, link)
    @title = title
    @desc = desc
    @link = link
  end

  def self.formatSections
    
  end

end

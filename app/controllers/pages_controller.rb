class PagesController < ApplicationController

  def index
#    @sections = [Section.new("anui", "c", "d"), Section.new("anui", "c", "d")]
    @sections = Page.last
  end
  
end

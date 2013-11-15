class PagesController < ApplicationController
  
  def index
    sections = Page.last
    colors = Color.all
    @sectionsAndColors = sections.zip(colors)
  end
  
end

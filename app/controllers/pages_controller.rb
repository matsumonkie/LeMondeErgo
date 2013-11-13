class PagesController < ApplicationController
  
  def index
    @sections = Page.last
  end
  
end

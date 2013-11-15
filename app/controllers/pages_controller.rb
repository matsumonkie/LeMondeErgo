class PagesController < ApplicationController
  
  def index
    @page = Page.last    
  end
  
end

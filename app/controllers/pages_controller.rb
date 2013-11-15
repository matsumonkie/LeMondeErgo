class PagesController < ApplicationController
  
  def index
    @sections = Page.last
    @colors ||= Color.all
  end
  
end

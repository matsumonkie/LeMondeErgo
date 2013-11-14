class PagesController < ApplicationController
  
  def index
    @sections = Page.last
    @colors ||= ["#1f0d67", "#fe2f2f", "#d50303", "#6faa12", "#006169", "#30932e", "#f20559", "#0cb4ae", "#ff6e17", "#1f0d67", "#fe2f2f", "#d50303", "#6faa12", "#006169", "#30932e", "#f20559", "#0cb4ae", "#ff6e17"]
  end
  
end

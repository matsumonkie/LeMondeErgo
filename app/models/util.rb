class Util
  
  def self.addWebsiteURLIfMissing(url)
    if (url.start_with?("/"))
      LeMondeErgo::Application::LE_MONDE_SITE_URL + url
    else
      url
    end       
  end

end

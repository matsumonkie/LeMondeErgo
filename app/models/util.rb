class Util
  
  def self.addWebsiteURLIfMissing(url)
    url = if (url.start_with?("/"))
      LeMondeErgo::Application::LE_MONDE_SITE_URL + url
    else
      url
    end
    
    return url
  end

  # [1,2,3,4] should become [[1,2], [3,4]]
  def self.joinArrayByPair(array)
    array.each_slice(2).to_a
  end

end

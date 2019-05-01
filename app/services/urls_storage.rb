class UrlsStorage
  include Singleton

  attr_reader :urls

  def initialize
    @urls = []
  end
end

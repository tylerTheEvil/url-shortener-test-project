class UrlsRepository
  class << self
    def create(url)
      short_url = ShortenUrlService.new.short_url
      full_url = { url: url, short_url: short_url }
      model << full_url
      full_url
    end

    def find_by_short_url(short_url)
      model.find { |u| u[:short_url] == short_url }
    end

    def all
      model
    end

    def first
      all.first
    end

    def destroy_all
      model.clear
    end

    def model
      UrlsStorage.instance.urls
    end
  end
end

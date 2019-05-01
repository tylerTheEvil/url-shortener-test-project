class UrlsRepository
  class << self
    def create(url)
      sanitized_url = sanitize_url(url)
      full_url = find_by_url(sanitized_url)
      return full_url unless full_url.nil?

      short_url = ShortenUrlService.new.short_url
      full_url = { url: sanitized_url, short_url: short_url }
      model << full_url
      full_url
    end

    def find_by_short_url(short_url)
      model.find { |u| u[:short_url] == short_url }
    end

    def find_by_url(url)
      model.find { |u| u[:url] == url }
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

    private

    def model
      UrlsStorage.instance.urls
    end

    def sanitize_url(url)
      return "https://#{url}" unless URI.parse(url).scheme
      url
    end
  end
end

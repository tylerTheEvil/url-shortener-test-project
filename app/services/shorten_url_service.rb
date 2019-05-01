class ShortenUrlService
  DICTIONARY = [Array('A'..'Z'), Array('a'..'z'), Array('0'..'9')].flatten.freeze
  DEFAULT_LENGTH = 6
  PREFIX = '/'.freeze

  def short_url(length = DEFAULT_LENGTH)
    generate_short_url(length)
  end

  private

  def generate_short_url(length)
    PREFIX + DICTIONARY.sample(length).join
  end
end

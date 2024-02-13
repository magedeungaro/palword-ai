# frozen_string_literal: true

class Scraper
  def initialize(url:, main_target:)
    @url = url
    @main_target = main_target
  end

  def scrape(&block)
    validate_types
    html.search(@main_target).each(&block)
  end

  private

  def html
    @html ||= Nokogiri::HTML.parse(URI.open(@url).read)
  end

  def validate_types
    return if @main_target.is_a?(String) || @url.is_a?(String)

    raise ArgumentError, 'main_target and url must be a String'
  end
end

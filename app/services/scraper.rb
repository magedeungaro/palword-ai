require 'open-uri'
require 'nokogiri'

class Scraper
  def initialize(url:, main_target:)
    @url = url
    @main_target = main_target
  end

  def scrape
    validate_types
    html.xpath(@main_target).each do |element|
      yield(element)
    end
  end

  private

  def html
    @html ||= Nokogiri::HTML(URI.open(@url))
  end

  def validate_types
    unless @main_target.is_a?(String) || @url.is_a?(String)
      raise ArgumentError, "main_target and url must be a String"
    end
  end
end

require 'nokogiri'

module MultiScraper
  module Adapters
    class NokogiriAdapter
      def self.parse_html(html)
        Nokogiri::HTML(html)
      end

      def self.parse_fragment(html)
        Nokogiri::HTML.fragment(html)
      end
    end
  end
end

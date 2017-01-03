require 'oga'

module MultiScraper
  module Adapters
    class OgaAdapter
      def self.parse_html(html)
        Oga.parse_html(html)
      end

      def self.parse_fragment(html)
        Oga.parse_html(html)
      end
    end
  end
end

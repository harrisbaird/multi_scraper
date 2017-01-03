require 'open-uri'

module MultiScraper
  module Properties
    class Feed < Base
      def parse
        xml = MultiScraper.request_adapter.perform(super)
        Feedjira::Feed.parse(xml)
      end

      def excluded?
        true
      end

      def self.key
        :feed
      end
    end
  end
end

MultiScraper.register_property(MultiScraper::Properties::Feed)

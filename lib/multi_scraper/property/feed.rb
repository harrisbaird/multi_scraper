module MultiScraper
  module Property
    class Feed < Value
      def parse(context)
        Feedjira::Feed.parse(super)
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

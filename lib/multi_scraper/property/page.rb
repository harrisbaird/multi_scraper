module MultiScraper
  module Property
    class Page < Value
      def parse(context)
        Nokogiri::HTML(super)
      end

      def excluded?
        true
      end

      def self.key
        :page
      end
    end
  end
end

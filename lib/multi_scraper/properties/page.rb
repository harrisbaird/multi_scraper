module MultiScraper
  module Properties
    class Page < Base
      def parse
        html = MultiScraper.request_adapter.perform(super)
        MultiScraper.page_adapter_class.parse_html(html)
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

MultiScraper.register_property(MultiScraper::Properties::Page)

module MultiScraper
  module Properties
    class Fragment < Base
      def parse
        value = super
        value = MultiScraper.page_adapter_class.parse_fragment(value) if value.respond_to?(:to_str)
        value
      end

      def excluded?
        true
      end

      def self.key
        :fragment
      end
    end
  end
end

MultiScraper.register_property(MultiScraper::Properties::Fragment)

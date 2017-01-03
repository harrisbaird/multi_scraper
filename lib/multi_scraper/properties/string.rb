module MultiScraper
  module Properties
    class String < Base
      def self.coerce(value)
        value = value.first if value.is_a?(Enumerable)
        value = value.text if value.respond_to?(:text)
        value.to_s.strip
      end

      def parse
        self.class.coerce(super)
      end

      def self.key
        :string
      end
    end
  end
end

MultiScraper.register_property(MultiScraper::Properties::String)

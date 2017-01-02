module MultiScraper
  module Property
    class Node < Value
      def parse(context)
        value = super

        return value if value.is_a?(Nokogiri::XML::Searchable)

        # Attempt to parse string as a Nokogiri fragment
        value.respond_to?(:to_str) && Nokogiri::HTML.fragment(value)
      end

      def excluded?
        true
      end

      def self.key
        :node
      end
    end
  end
end

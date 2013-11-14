module MultiScraper
  module Property
    class String < Value
      def parse(context)
        value = super
        value = value.first if value.is_a?(Enumerable)
        value = value.text if value.is_a?(Nokogiri::XML::Node)
        value = value.to_s if value.respond_to?(:to_s)
        value
      end

      def self.key
        :string
      end
    end
  end
end

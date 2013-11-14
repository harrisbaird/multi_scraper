module MultiScraper
  module Option
    class Selector
      def self.handles_key?(context, key)
        property, type = parse_key(key)
        type && context.respond_to?(property)
      end

      def self.parse(context, _value, option_key, option_value)
        property, type = parse_key(option_key)
        page = context.send(property)
        page.send(type, option_value)
      end

      def self.parse_key(key)
        key.to_s.match(/(.+)_(xpath|css)/).captures
      rescue
        false
      end
    end
  end
end

module MultiScraper
  module Option
    class Regex
      def self.handles_key?(_context, key)
        key == :regex
      end

      def self.parse(_context, value, _option_key, option_value)
        pattern, position = *option_value
        result = pattern.match(value.to_s)
        position ? result[position] : result
      end
    end
  end
end

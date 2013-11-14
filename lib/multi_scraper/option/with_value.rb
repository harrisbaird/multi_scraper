module MultiScraper
  module Option
    class WithValue
      def self.handles_key?(_context, key)
        [:with, :before, :after].include? key
      end

      def self.parse(_context, _value, _option_key, option_value)
        option_value
      end
    end
  end
end

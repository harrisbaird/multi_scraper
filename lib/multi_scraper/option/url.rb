require 'open-uri'

module MultiScraper
  module Option
    class Url
      def self.handles_key?(_context, key)
        key == :url
      end

      def self.parse(_context, _value, _option_key, option_value)
        open(option_value, 'User-Agent' => MultiScraper.configuration.user_agent, &:read)
      end
    end
  end
end

module MultiScraper
  module Option
    class CallMethod
      def self.handles_key?(context, key)
        context.respond_to? key
      end

      def self.parse(context, _value, option_key, option_value)
        subject = context.send(option_key)
        unless subject.respond_to? option_value
          raise MultiScraper::InvalidMethod, "#{option_key} does not repond to #{option_value}"
        end
        subject.send(option_value)
      end
    end
  end
end

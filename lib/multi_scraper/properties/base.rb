module MultiScraper
  module Properties
    class Base
      XPATH_REGEX = /^\.?\/\//

      def initialize(key, property_group, options = {}, &block)
        @key = key
        @property_group = property_group
        @options = [*options]
        @block = block
      end

      def parse
        @options.inject('') do |memo, option|
          option = @property_group.instance_exec(memo, &option) if option.is_a? Proc

          case option
          when Symbol
            memo != '' ? memo.send(option) : @property_group.invoke_method(option)
          when XPATH_REGEX
            memo.xpath(option)
          when Regexp
            memo.scan(option)
          else
            option
          end
        end
      end

      def excluded?
        false
      end
    end
  end
end

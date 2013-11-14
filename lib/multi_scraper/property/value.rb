module MultiScraper
  module Property
    class Value
      attr_reader :options
      def initialize(options = {})
        unless options.is_a? Hash
          raise(MissingOptionsHash, "Options must be a Hash, not '#{options}'")
        end
        @options = options
      end

      def parse(context)
        @options.reduce('') do |res, (k, v)|
          opt = MultiScraper::Option.find(context, k)
          next unless opt
          v = context.instance_exec(res, &v) if v.respond_to?(:call)
          opt.parse(context, res, k, v)
        end
      end

      def excluded?
        false
      end

      def self.key
        :value
      end
    end
  end
end

module MultiScraper
  module Property
    class Array < Value
      def initialize(options = {}, &block)
        super(options)
        @callback = block if block_given?
      end

      def parse(context)
        return [*super] unless @callback
        iterator = super
        iterator = 1.times unless iterator.is_a?(Enumerable)
        iterator.reduce([]) do |arr, entry|
          group = PropertyGroup.new(context, entry)
          group.instance_eval(&@callback)
          arr << group.parse(context)
        end
      end

      def self.key
        :array
      end
    end
  end
end

module MultiScraper
  module Property
    class Group < Value
      def initialize(options = {}, &block)
        super(options)
        @callback = block
      end

      def parse(context)
        group = PropertyGroup.new(context)
        group.instance_eval(&@callback)
        group.parse(context)
      end

      def self.key
        :group
      end
    end
  end
end

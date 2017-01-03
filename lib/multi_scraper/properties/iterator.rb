module MultiScraper
  module Properties
    class Iterator < Base
      def set_callback(&block)
        @callback = block
      end

      def parse
        iterator = super
        iterator = 1.times unless iterator.is_a?(Enumerable)

        iterator.reduce([]) do |arr, current|
          group = PropertyGroup.new(@property_group)

          group.define_singleton_method(:current) { current }

          group.instance_exec(current, &@block)

          if @callback
            @callback.call(group)
          else
            arr << group.parse
          end
        end
      end

      def self.key
        :iterator
      end
    end
  end
end

MultiScraper.register_property(MultiScraper::Properties::Iterator)

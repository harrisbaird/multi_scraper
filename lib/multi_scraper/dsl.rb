module MultiScraper
  module DSL
    module InstanceMethods
      def initialize(&block)
        instance_eval(&block) if block_given?
      end

      def method_missing(sym, *args, &block)
        self.class.send sym, *args, &block
      end
    end

    module ClassMethods
      def metadata
        @metadata ||= PropertyGroup.new
      end

      def method_missing(method, *args, &block)
        metadata.send method, *args, &block
      end

      def add_callback(key, &block)
        unless metadata[key].is_a?(MultiScraper::Properties::Iterator)
          raise InvalidCallback, "#{key} must be a root property and of type Iterator"
        end

        metadata[key].set_callback(&block)
      end
    end
  end
end

module MultiScraper
  class PropertyGroup < Hash
    attr_reader :ancestor, :entry
    def initialize(ancestor = nil, entry = nil)
      @ancestor = ancestor
      @entry = entry
      @values = {}
      setup_property_methods
    end

    def parse(_context = nil)
      each_with_object({}) do |(key, prop), hash|
        hash[key] = prop.parse(self) unless prop.excluded?
      end
    end

    def setup_property_methods
      MultiScraper::Property.classes.each do |klass|
        define_singleton_method(klass.key) do |name, options = {}, &block|
          define_property(klass, name, options, &block)
        end
      end
    end

    def define_property(klass, name, options, &block)
      self[name] = klass.new(options, &block)
      define_singleton_method(name) do
        @values[name] ||= self[name].parse(self)
      end
    end

    def respond_to?(method)
      super || @ancestor.respond_to?(method)
    end

    def method_missing(method, *args, &block)
      @ancestor && @ancestor.send(method, *args, &block) || super
    end
  end
end

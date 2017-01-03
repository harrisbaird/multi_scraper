require 'multi_scraper/properties/base'
require 'multi_scraper/properties/array'
require 'multi_scraper/properties/feed'
require 'multi_scraper/properties/fragment'
require 'multi_scraper/properties/group'
require 'multi_scraper/properties/integer'
require 'multi_scraper/properties/iterator'
require 'multi_scraper/properties/page'
require 'multi_scraper/properties/string'
require 'multi_scraper/properties/value'


module MultiScraper
  class PropertyGroup < Hash
    def initialize(ancestor = nil)
      @ancestor = ancestor
      @values = {}
      setup_property_methods
    end

    def parse
      each_with_object({}) do |(key, prop), hash|
        # TODO: if callback, don't parse
        hash[key] = prop.parse unless prop.excluded?
      end
    end

    def respond_to?(method)
      super || @ancestor.respond_to?(method)
    end

    def method_missing(method, *args, &block)
      @ancestor && @ancestor.send(method, *args, &block) || super
    end

    def invoke_method(method)
      raise "Failed to call: #{method}" unless respond_to?(method)
      send(method)
    end

    private

    def setup_property_methods
      MultiScraper.properties.each do |klass|
        define_singleton_method(klass.key) do |name, options = {}, &block|
          define_property(klass, name, options, &block)
        end
      end
    end

    def define_property(klass, name, options, &block)
      self[name] = klass.new(name, self, options, &block)

      define_singleton_method(name) do
        @values[name] ||= self[name].parse
      end
    end
  end
end

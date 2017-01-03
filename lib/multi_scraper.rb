require 'feedjira'
require 'multi_scraper/openuri_request'

module MultiScraper
  class MissingPage < StandardError; end
  class MissingPageAdapter < StandardError; end
  class InvalidCallback < StandardError; end

  class << self
    attr_reader :page_adapter
    attr_writer :request_adapter
    attr_writer :user_agent

    def included(base)
      base.send(:include, DSL::InstanceMethods)
      base.extend(DSL::ClassMethods)
    end

    def new(&block)
      klass = Class.new
      klass.send(:include, MultiScraper)
      klass.new(&block)
    end

    def parse(&block)
      new(&block).parse
    end

    def configure
      yield self
    end

    def properties
      @properties ||= []
    end

    def register_property(klass)
      properties.unshift klass
    end

    def user_agent
      @user_agent ||= 'MultiScraper'
    end

    def page_adapter=(page_adapter)
      require "multi_scraper/page_adapters/#{page_adapter}_adapter"
      @page_adapter = page_adapter
    end

    def page_adapter_class
      raise MissingPageAdapter unless page_adapter
      MultiScraper.const_get("Adapters::#{page_adapter.capitalize}Adapter")
    end

    def request_adapter
      @request_adapter ||= MultiScraper::OpenuriRequest
    end
  end
end

require 'multi_scraper/property_group'
require 'multi_scraper/dsl'

# Attempt to load page adapter
[:nokogiri, :oga].each do |page_adapter|
  begin
    MultiScraper.page_adapter = page_adapter
    break
  rescue LoadError
  end
end

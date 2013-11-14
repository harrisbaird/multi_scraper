require 'feedjira'
require 'nokogiri'
require 'multi_scraper/configuration'
require 'multi_scraper/property'
require 'multi_scraper/property_group'
require 'multi_scraper/option'
require 'multi_scraper/dsl'

module MultiScraper
  class MissingPage < StandardError; end
  class MissingOptionsHash < StandardError; end
  class InvalidOption < StandardError; end
  class InvalidMethod < StandardError; end

  class << self
    def new(&block)
      klass = Class.new
      klass.send(:include, MultiScraper)
      klass.fetch(&block)
    end

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end

    def add_property(klass)
      MultiScraper::Property.classes.unshift klass
    end

    def add_option(klass)
      MultiScraper::Option.classes.unshift klass
    end
  end
end

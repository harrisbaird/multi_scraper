require 'multi_scraper/property/value'
require 'multi_scraper/property/array'
require 'multi_scraper/property/feed'
require 'multi_scraper/property/group'
require 'multi_scraper/property/integer'
require 'multi_scraper/property/node'
require 'multi_scraper/property/page'
require 'multi_scraper/property/string'

module MultiScraper
  module Property
    def self.classes
      @classes ||= [MultiScraper::Property::Value,
                    MultiScraper::Property::Array,
                    MultiScraper::Property::Feed,
                    MultiScraper::Property::Group,
                    MultiScraper::Property::Integer,
                    MultiScraper::Property::Node,
                    MultiScraper::Property::Page,
                    MultiScraper::Property::String]
    end
  end
end

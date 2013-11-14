require 'multi_scraper/option/call_method'
require 'multi_scraper/option/regex'
require 'multi_scraper/option/selector'
require 'multi_scraper/option/url'
require 'multi_scraper/option/with_value'

module MultiScraper
  module Option
    def self.classes
      @classes ||= [MultiScraper::Option::CallMethod,
                    MultiScraper::Option::Regex,
                    MultiScraper::Option::Selector,
                    MultiScraper::Option::Url,
                    MultiScraper::Option::WithValue]
    end

    def self.find(context, key)
      classes.find { |option| option.handles_key?(context, key) } ||
        raise(MultiScraper::InvalidOption, "Unknown option: #{key}")
    end
  end
end

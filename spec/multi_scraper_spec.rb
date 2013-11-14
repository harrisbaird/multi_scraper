require 'spec_helper'

describe MultiScraper do
  describe '.configure' do
    it 'provides configuration with a block' do
      MultiScraper.configure do |config|
        config.user_agent = 'New user agent'
      end
      expect(MultiScraper.configuration.user_agent).to eq 'New user agent'
    end
  end

  describe '.add_property' do
    it 'registers a class as a new property' do
      klass = Class.new
      MultiScraper.add_property(klass)
      expect(MultiScraper::Property.classes).to include klass
      MultiScraper::Property.classes.delete klass
    end
  end

  describe '.add_option' do
    it 'registers a class as a new option' do
      klass = Class.new
      MultiScraper.add_option(klass)
      expect(MultiScraper::Option.classes).to include klass
      MultiScraper::Option.classes.delete klass
    end
  end
end

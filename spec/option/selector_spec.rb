require 'spec_helper'
describe MultiScraper::Option::Selector do
  describe '.handles_key?' do
    context 'with an invalid page' do
      subject do
        MultiScraper.new { string :invalid_page, missing_xpath: 'test' }
      end

      it { expect { subject }.to raise_error MultiScraper::InvalidOption }
    end
    context 'with a valid page and an invalid type' do
      subject do
        MultiScraper.new do
          page :simple, with: 'test'
          string :invalid_type, simple_invalid: 'test'
        end
      end

      it { expect { subject }.to raise_error MultiScraper::InvalidOption }
    end
  end
  describe '.parse' do
    subject do
      MultiScraper.new do
        page :google, url: 'http://google.com'
        node :test_node, with: '<p>Hello <strong>world!</strong></p>'
        string :xpath_page, google_xpath: '//title'
        string :xpath_node, test_node_xpath: 'p/strong'
        string :css_page, google_css: 'title'
        string :css_node, test_node_css: 'p strong'
      end
    end

    it 'queries pages' do
      expect(subject[:xpath_page]).to eq 'Google'
      expect(subject[:css_page]).to eq 'Google'
    end

    it 'queries nodes' do
      expect(subject[:xpath_node]).to eq 'world!'
      expect(subject[:css_node]).to eq 'world!'
    end
  end
end

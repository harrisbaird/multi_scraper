
require 'spec_helper'
describe MultiScraper::Property::Node do
  describe '.parse' do
    subject do
      MultiScraper.new do
        node :test_node, with: '<strong>Hello</strong>'
        string :hello, test_node_xpath: 'strong'
      end
    end

    it 'excludes the node from the returned hash' do
      expect(subject[:hello]).to eq 'Hello'
      expect(subject).not_to include :test_node
    end
  end
end

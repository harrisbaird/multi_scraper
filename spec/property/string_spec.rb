require 'spec_helper'
describe MultiScraper::Property::String do
  describe '.parse' do
    let(:result) do
      MultiScraper.new do
        node :simple, with: '<a href="http://example.com">test</a>'
        string :string_value, with: 'hello world'
        string  :int_value,   with: 42
        string  :array_value, with: %w(hello world)
        string  :parsed_node, simple_xpath: 'a/@href'
      end
    end

    context 'with string value' do
      subject { result[:string_value] }
      it { is_expected.to eq 'hello world' }
      it { is_expected.to be_a String }
    end

    context 'with non string value' do
      subject { result[:int_value] }
      it { is_expected.to eq '42' }
      it { is_expected.to be_a String }
    end

    context 'with an Enumerable' do
      subject { result[:array_value] }
      it { is_expected.to eq 'hello' }
      it { is_expected.to be_a String }
    end

    context 'with a Nokogiri node' do
      subject { result[:parsed_node] }
      it { is_expected.to eq 'http://example.com' }
      it { is_expected.to be_a String }
    end
  end
end

require 'spec_helper'
describe MultiScraper::Option::CallMethod do
  describe '.parse' do
    context 'with valid subject and method' do
      let(:result) do
        MultiScraper.new do
          page :test, url: 'http://google.com'
          string :doc_title, test: :title
          group :simple_group do
            value :title_size, doc_title: :size
          end
        end
      end

      it 'calls "title" method on "test" object' do
        expect(result[:doc_title]).to eq 'Google'
      end

      it 'can call parent PropertyGroup' do
        expect(result[:simple_group][:title_size]).to eq 6
      end
    end

    context 'with valid subject and invalid method' do
      it 'raises MultiScraper::InvalidMethod' do
        expect do
          MultiScraper.new do
            page :test, url: 'http://google.com'
            string :doc_title, test: :invalid
          end
        end.to raise_error MultiScraper::InvalidMethod
      end
    end

    context 'with invalid subject' do
      it 'raises MultiScraper::InvalidOption' do
        expect do
          MultiScraper.new { string :doc_title, invalid: :invalid }
        end.to raise_error MultiScraper::InvalidOption
      end
    end
  end
end

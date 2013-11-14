require 'spec_helper'

describe MultiScraper::Property::Page do
  describe '.parse' do
    subject do
      MultiScraper.new do
        page :reddit, url: 'https://www.reddit.com'
        string :title, reddit_xpath: '//title'
      end
    end

    it 'excludes the page from the returned hash' do
      expect(subject[:title]).to eq 'reddit: the front page of the internet'
      expect(subject).not_to include :reddit
    end
  end
end

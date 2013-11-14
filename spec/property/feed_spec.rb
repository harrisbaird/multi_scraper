require 'spec_helper'
describe MultiScraper::Property::Feed do
  describe '.parse' do
    subject do
      MultiScraper.new do
        feed :reddit, url: 'https://www.reddit.com/.rss'
        value :count, with: proc { reddit.entries.size }
      end
    end

    it 'excludes the feed from the returned hash' do
      expect(subject[:count]).to eq 25
      expect(subject).not_to include :reddit
    end
  end
end

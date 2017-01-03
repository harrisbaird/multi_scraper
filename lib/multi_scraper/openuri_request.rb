require 'open-uri'

module MultiScraper
  module OpenuriRequest
    def self.perform(url)
      open(url, 'User-Agent' => MultiScraper.user_agent) { |io| io.read }
    end
  end
end

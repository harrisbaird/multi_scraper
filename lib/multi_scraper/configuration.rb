require 'logger'

module MultiScraper
  class Configuration
    attr_accessor :user_agent, :download_adapter
    def initialize
      @user_agent = 'MultiScraper'
    end
  end
end

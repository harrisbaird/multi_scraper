module MultiScraper
  module Properties
    class Value < Base
      def parse
        super
      end

      def self.key
        :value
      end
    end
  end
end

MultiScraper.register_property(MultiScraper::Properties::Value)

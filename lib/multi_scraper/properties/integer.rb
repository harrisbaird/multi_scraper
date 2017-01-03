module MultiScraper
  module Properties
    class Integer < Base
      def parse
        Integer(super)
      end

      def self.key
        :integer
      end
    end
  end
end

MultiScraper.register_property(MultiScraper::Properties::Integer)

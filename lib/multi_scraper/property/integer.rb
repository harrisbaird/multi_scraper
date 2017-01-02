module MultiScraper
  module Property
    class Integer < Value
      def parse(_content)
        Integer(super)
      end

      def self.key
        :integer
      end
    end
  end
end

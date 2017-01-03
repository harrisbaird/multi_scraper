module MultiScraper
  module Properties
    class Array < Base
      def parse
        return [*@options].map { |v| Properties::String.coerce(v) }
      end

      def self.key
        :array
      end
    end
  end
end

MultiScraper.register_property(MultiScraper::Properties::Array)

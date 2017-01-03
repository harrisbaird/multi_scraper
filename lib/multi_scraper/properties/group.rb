module MultiScraper
  module Properties
    class Group < Base
      def parse
        PropertyGroup.new(@property_group).parse
      end

      def self.key
        :group
      end
    end
  end
end

MultiScraper.register_property(MultiScraper::Properties::Group)

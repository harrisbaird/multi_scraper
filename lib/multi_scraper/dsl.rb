module MultiScraper
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end

  module InstanceMethods
    def method_missing(sym, *args, &block)
      self.class.send sym, *args, &block
    end
  end

  module ClassMethods
    def metadata
      @metadata ||= PropertyGroup.new
    end

    def method_missing(method, *args, &block)
      metadata.send method, *args, &block
    end

    def fetch(&block)
      instance_eval(&block) if block
      new.parse
    end
  end
end

require 'spec_helper'

describe MultiScraper::PropertyGroup do
  describe '.method_missing' do
    subject do
      MultiScraper.new { string :missing, with: proc { invalid_method } }
    end

    it 'raises NameError on failure' do
      expect { subject }.to raise_error NameError
    end
  end
end

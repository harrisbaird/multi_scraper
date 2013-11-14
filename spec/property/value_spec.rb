
require 'spec_helper'
class TestClass
  include MultiScraper
  string :after_value,  with: proc { proc_value }
  string :proc_value,   with: proc { 'proc evaluated' }
end
describe MultiScraper::Property::Value do
  describe 'initialize' do
    context 'with value other than a Hash' do
      subject { MultiScraper.new { string :testing, '' } }
      it 'raises an MissingOptionsHash exception' do
        expect { subject }.to raise_error MultiScraper::MissingOptionsHash
      end
    end
  end
  describe '.parse' do
    subject { TestClass.fetch[:after_value] }
    context 'with proc value' do
      it 'can call properties defined after the current' do
        is_expected.to eq 'proc evaluated'
      end
    end
  end
end

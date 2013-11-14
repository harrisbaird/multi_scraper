require 'spec_helper'

describe MultiScraper::Option do
  describe '.find' do
    context 'with a valid key' do
      it 'returns the correct option class' do
        expect(MultiScraper::Option.find(self, :regex)).to eq MultiScraper::Option::Regex
      end
    end
    context 'with an invalid key' do
      it 'raises an exception' do
        expect { MultiScraper::Option.find(self, :invalid) }.to raise_error MultiScraper::InvalidOption
      end
    end
  end
end

require 'spec_helper'
describe MultiScraper::Option::Regex do
  describe '.handles_key?' do
    context 'with a valid key' do
      subject { MultiScraper::Option::Regex.handles_key? self, :regex }
      it { is_expected.to be true }
    end

    context 'with an invalid key' do
      subject { MultiScraper::Option::Regex.handles_key? self, :invalid }
      it { is_expected.to be false }
    end

    context 'with nil' do
      subject { MultiScraper::Option::Regex.handles_key? self, nil }
      it { is_expected.to be false }
    end
  end
  describe '.parse' do
    let(:result) do
      MultiScraper.new do
        value :with_pos,    with: 'hello world',
                            regex: [/^(.+)\s/, 1]
        value :without_pos, with: 'hello world',
                            regex: /^(.+)\s/
      end
    end

    context 'with array given containing position to return' do
      subject { result[:with_pos] }
      it { is_expected.to eq 'hello' }
      it { is_expected.to be_a String }
    end

    context 'with regex value' do
      subject { result[:without_pos] }
      it { expect(subject[1]).to eq 'hello' }
      it { is_expected.to be_a MatchData }
    end
  end
end

require 'spec_helper'
describe MultiScraper::Property::Array do
  describe '.parse' do
    let(:result) do
      MultiScraper.new do
        array :string_value, with: 'string'
        array :array_value,  with: ['string']
        array :nested_value, with: [[1, 2, 3], [4, 5, 6]]
        array :block do
          string :hello, with: 'world'
        end
        array :block_enumerable, with: 10.times do
          string :hello, with: 'world'
        end
        group :block_nested do
          string :nested_value, with: 'test'
          group :nested do
            string :nested_value, with: 'test'
          end
        end
      end
    end

    context 'with string value' do
      subject { result[:string_value] }
      it { is_expected.to have(1).item }
      it { is_expected.to eq ['string'] }
    end

    context 'with array value' do
      subject { result[:array_value] }
      it { is_expected.to have(1).item }
      it { is_expected.to eq ['string'] }
    end

    context 'with nested array value' do
      subject { result[:nested_value] }
      it { is_expected.to have(2).items }
      it { is_expected.to eq [[1, 2, 3], [4, 5, 6]] }
    end

    context 'with block value' do
      subject { result[:block] }
      it { is_expected.to have(1).item }
      it { expect(subject.first[:hello]).to eq 'world' }
    end

    context 'with block and enumerable value' do
      subject { result[:block_enumerable] }
      it { is_expected.to have(10).item }
      it { expect(subject.first[:hello]).to eq 'world' }
    end

    context 'with nested blocks' do
      it do
        expect(result[:block_nested]).to match(nested_value: 'test',
                                               nested: {
                                                 nested_value: 'test'
                                               })
      end
    end
  end
end

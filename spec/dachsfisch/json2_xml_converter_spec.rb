# frozen_string_literal: true

RSpec.describe Dachsfisch::JSON2XMLConverter do
  describe '.new' do
    subject(:converter) { described_class.new(json:) }

    let(:json) { '{"foo": "bar"}' }

    it 'assigns parsed json' do
      expect(converter.instance_variable_get(:@json_hash)).to be { 'foo' => 'bar' }
    end

    context 'with invalid json' do
      let(:json) { '{"foo": {"bar"}' }

      it 'throws an Error' do
        expect { converter }.to raise_error(Dachsfisch::InvalidJSONInputError, "unexpected token at '{\"foo\": {\"bar\"}'")
      end
    end

    context 'with nil as json' do
      let(:json) { nil }

      it 'throws an Error' do
        expect { converter }.to raise_error(Dachsfisch::InvalidJSONInputError, 'no implicit conversion of nil into String')
      end
    end

    context 'with a json that would result in multiple root nodes' do
      let(:json) { '{"foo": "bar", "foobar": "barfoo"}' }

      it 'throws an Error' do
        expect { converter }.to raise_error(Dachsfisch::InvalidJSONInputError, 'multiple root nodes are not supported')
      end
    end
  end

  describe '#perform' do
    subject { converter.perform }

    let(:converter) { described_class.new json: }

    Examples.each :json2xml do |example|
      context "with #{example.name}" do
        let(:json) { example.json }

        it { is_expected.to be_equivalent_to(example.xml) }
      end
    end
  end
end

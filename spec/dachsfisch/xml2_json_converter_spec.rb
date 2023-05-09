# frozen_string_literal: true

RSpec.describe Dachsfisch::XML2JSONConverter do
  describe '.new' do
    subject(:converter) { described_class.new(xml:) }

    let(:xml) { '<a></a>' }

    it 'assigns parsed xml' do
      expect(converter.instance_variable_get(:@doc)).to be { Nokogiri::XML(xml) }
    end

    context 'with invalid xml' do
      let(:xml) { '<a>' }

      it 'throws an Error' do
        expect { converter }.to raise_error(Dachsfisch::InvalidXMLInputError)
      end
    end

    context 'with nil' do
      let(:xml) { nil }

      it 'throws an Error' do
        expect { converter }.to raise_error(Dachsfisch::InvalidXMLInputError, 'input empty')
      end
    end

    context 'with empty string' do
      let(:xml) { '' }

      it 'throws an Error' do
        expect { converter }.to raise_error(Dachsfisch::InvalidXMLInputError, 'input empty')
      end
    end
  end

  describe '#perform' do
    subject { converter.perform }

    let(:converter) { described_class.new xml: }

    Examples.each :xml2json do |example|
      context "with #{example.name}" do
        let(:xml) { example.xml }

        it { is_expected.to be_an_equal_json_as(example.json) }
      end
    end
  end
end

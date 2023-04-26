# frozen_string_literal: true

RSpec.describe Dachsfisch::JSON2XMLConverter do
  describe '#perform' do
    subject(:xml) { converter.perform }

    let(:json) { example.json }
    let(:converter) { described_class.new json: }

    context 'with example 2' do
      let(:example) { Examples::Example2 }

      it 'converts to correct xml' do
        expect(xml).to be_equivalent_to(example.xml)
      end
      # xml.alice 'bob'
    end

    context 'with example 3' do
      let(:example) { Examples::Example3 }

      it 'converts to correct xml' do
        expect(xml).to be_equivalent_to(example.xml)
      end
    end

    context 'with example 4' do
      let(:example) { Examples::Example4 }

      it 'converts to correct xml' do
        expect(xml).to be_equivalent_to(example.xml)
      end
    end

    context 'with example 5' do
      let(:example) { Examples::Example5 }

      it 'converts to correct xml' do
        expect(xml).to be_equivalent_to(example.xml)
      end
    end

    context 'with example 7' do
      let(:example) { Examples::Example7 }

      it 'converts to correct xml' do
        expect(xml).to be_equivalent_to(example.xml)
      end
    end

    context 'with example 8' do
      let(:example) { Examples::Example8 }

      it 'converts to correct xml' do
        expect(xml).to be_equivalent_to(example.xml)
      end
    end

    context 'with example 9' do
      let(:example) { Examples::Example9 }

      it 'converts to correct xml' do
        expect(xml).to be_equivalent_to(example.xml)
      end
    end
  end
end

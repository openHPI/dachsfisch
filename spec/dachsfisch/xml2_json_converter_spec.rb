# frozen_string_literal: true

RSpec.describe Dachsfisch::XML2JSONConverter do
  describe '#perform' do
    subject(:json) { converter.perform }

    let(:json_hash) { JSON.parse(json) }
    let(:converter) { described_class.new xml: }

    context 'with example 2' do
      let(:example) { Examples::Example2 }
      let(:xml) { example.xml }

      it 'converts to correct json' do
        expect(json).to be_an_equal_json_as(example.json)
      end
    end

    context 'with example 3' do
      let(:example) { Examples::Example3 }
      let(:xml) { example.xml }

      it 'converts to correct json' do
        expect(json).to be_an_equal_json_as(example.json)
      end
    end

    context 'with example 4' do
      let(:example) { Examples::Example4 }
      let(:xml) { example.xml }

      it 'converts to correct json' do
        expect(json).to be_an_equal_json_as(example.json)
      end
    end

    context 'with example 5' do
      let(:example) { Examples::Example5 }
      let(:xml) { example.xml }

      it 'converts to correct json' do
        expect(json).to be_an_equal_json_as(example.json)
      end
    end

    context 'with example 7' do
      let(:example) { Examples::Example7 }
      let(:xml) { example.xml }

      it 'converts to correct json' do
        expect(json).to be_an_equal_json_as(example.json)
      end
    end

    context 'with example 8' do
      let(:example) { Examples::Example8 }
      let(:xml) { example.xml }

      it 'converts to correct json' do
        expect(json).to be_an_equal_json_as(example.json)
      end
    end

    context 'with example 9' do
      let(:example) { Examples::Example9 }
      let(:xml) { example.xml }

      it 'converts to correct json' do
        expect(json).to be_an_equal_json_as(example.json)
      end
    end
  end
end

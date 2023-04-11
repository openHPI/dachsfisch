# frozen_string_literal: true

RSpec.describe Dachsfisch::XML2JSONConverter do
  describe '#perform' do
    subject(:json) { converter.perform }

    let(:json_hash) { JSON.parse(json) }
    let(:converter) { described_class.new xml: }
    let(:xml) { example.xml }

    context 'with example 2' do
      let(:example) { Examples::Example2 }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with example 3' do
      let(:example) { Examples::Example3 }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with example 4' do
      let(:example) { Examples::Example4 }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with example 5' do
      let(:example) { Examples::Example5 }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with example 7' do
      let(:example) { Examples::Example7 }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with example 8' do
      let(:example) { Examples::Example8 }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with example 9' do
      let(:example) { Examples::Example9 }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with multiple text nodes' do
      let(:example) { Examples::CustomExampleMultipleTextNodes }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with a comment' do
      let(:example) { Examples::CustomExampleComment }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end

    context 'with cdata' do
      let(:example) { Examples::CustomExampleCdata }

      it { is_expected.to be_an_equal_json_as(example.json) }
    end
  end
end

# frozen_string_literal: true

RSpec.describe Dachsfisch::JSON2XMLConverter do
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

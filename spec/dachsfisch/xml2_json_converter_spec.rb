# frozen_string_literal: true

RSpec.describe Dachsfisch::XML2JSONConverter do
  describe '#perform' do
    subject(:json) { converter.perform }

    let(:converter) { described_class.new xml: }

    Examples.each do |example|
      context "with #{example.name}" do
        let(:xml) { example.xml }

        it { is_expected.to be_an_equal_json_as(example.json) }
      end
    end
  end
end

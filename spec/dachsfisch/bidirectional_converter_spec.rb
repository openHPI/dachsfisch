# frozen_string_literal: true

RSpec.describe 'BidirectionalConverter' do
  let(:xml2_json) { Dachsfisch::XML2JSONConverter }
  let(:json2_xml) { Dachsfisch::JSON2XMLConverter }

  context 'with valid XML' do
    describe '#perform' do
      subject { json2_xml.perform json: }

      let(:json) { xml2_json.perform xml: }

      Examples.each :json2xml do |example|
        context "with #{example.name}" do
          let(:xml) { example.xml }

          it { is_expected.to be_equivalent_to(xml) }
          it { is_expected.to have_equal_namespace_definitions_as(xml) }
        end
      end
    end
  end

  context 'with valid JSON' do
    describe '#perform' do
      subject { xml2_json.perform xml: }

      let(:xml) { json2_xml.perform json: }

      Examples.each :xml2json do |example|
        context "with #{example.name}" do
          let(:json) { example.json }

          it { is_expected.to be_an_equal_json_as(json) }
        end
      end
    end
  end
end

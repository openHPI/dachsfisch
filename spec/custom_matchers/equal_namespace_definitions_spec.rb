# frozen_string_literal: true

RSpec.describe 'equal_namespace_definitions matcher' do
  let(:xml) { Examples::Example2.xml }
  let(:xml2) { Examples::Example2.xml }

  it 'successfully compares two similar xml strings' do
    expect(xml).to have_equal_namespace_definitions_as xml2
  end

  context 'when one of the classes is not a string' do
    let(:string) { 'hello' }
    let(:integer) { 1234 }

    it 'fails' do
      expect(string).not_to have_equal_namespace_definitions_as integer
    end

    it 'provides a useful error message' do
      expect { expect(string).to have_equal_namespace_definitions_as integer }
        .to raise_error(RSpec::Expectations::ExpectationNotMetError, /does not have equal namespaces as/)
    end
  end

  context 'when one of the strings does not contain valid xml' do
    let(:xml2) { 'foobar' }

    it 'fails' do
      expect(xml).not_to have_equal_namespace_definitions_as xml2
    end

    it 'provides a useful error message' do
      expect { expect(xml).to have_equal_namespace_definitions_as xml2 }
        .to raise_error(RSpec::Expectations::ExpectationNotMetError, /does not have equal namespaces as/)
    end
  end

  context 'when one xml string is different' do
    let(:xml2) { Examples::Example3.json }

    it 'fails the comparison' do
      expect(xml).not_to have_equal_namespace_definitions_as xml2
    end

    it 'provides a useful error message' do
      expect { expect(xml).to have_equal_namespace_definitions_as xml2 }
        .to raise_error(RSpec::Expectations::ExpectationNotMetError, /does not have equal namespaces as/)
    end
  end

  context 'with namespaces' do
    let(:xml) do
      <<-XML
        <alice xmlns="http://some-namespace" xmlns:charlie="http://some-other-namespace">
          <bob>david</bob>
          <charlie:edgar>frank</charlie:edgar>
        </alice>
      XML
    end

    context 'with unequal namespace definitions' do
      let(:xml2) do
        <<~XML
          <alice xmlns:charlie="http://some-other-namespace" xmlns="http://some-namespace">
            <bob>david</bob>
            <charlie:edgar xmlns:charlie="http://some-other-namespace" xmlns="http://some-namespace">
              frank
            </charlie:edgar>
          </alice>
        XML
      end

      it 'fails the comparison' do
        expect(xml).not_to have_equal_namespace_definitions_as xml2
      end

      it 'provides a useful error message' do
        expect { expect(xml).to have_equal_namespace_definitions_as xml2 }
          .to raise_error(RSpec::Expectations::ExpectationNotMetError, /does not have equal namespaces as/)
      end
    end

    context 'with similar namespace definitions' do
      let(:xml2) do
        <<~XML
          <alice xmlns:charlie="http://some-other-namespace" xmlns="http://some-namespace">
            <bob>david</bob>
            <charlie:edgar>frank</charlie:edgar>
          </alice>
        XML
      end

      it 'successfully compares two similar xml strings' do
        expect(xml).to have_equal_namespace_definitions_as xml2
      end
    end
  end
end

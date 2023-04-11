# frozen_string_literal: true

RSpec.describe 'equal_json matcher' do
  let(:json) { Examples::Example2.json }
  let(:json2) { Examples::Example2.json }

  it 'successfully compares two similar json strings' do
    expect(json).to be_an_equal_json_as json2
  end

  context 'when one of the classes is not a string' do
    let(:string) { 'hello' }
    let(:integer) { 1234 }

    it 'fails' do
      expect(string).not_to be_an_equal_json_as integer
    end

    it 'provides a useful error message' do
      expect { expect(string).to be_an_equal_json_as integer }
        .to raise_error(RSpec::Expectations::ExpectationNotMetError, /not equal to/)
    end
  end

  context 'when one of the strings does not contain valid json' do
    let(:json2) { 'foobar' }

    it 'fails' do
      expect(json).not_to be_an_equal_json_as json2
    end

    it 'provides a useful error message' do
      expect { expect(json).to be_an_equal_json_as json2 }
        .to raise_error(RSpec::Expectations::ExpectationNotMetError, /not equal to/)
    end
  end

  context 'when one json string is different' do
    let(:json2) { Examples::Example3.json }

    it 'fails the comparison' do
      expect(json).not_to be_an_equal_json_as json2
    end

    it 'provides a useful error message' do
      expect { expect(json).to be_an_equal_json_as json2 }
        .to raise_error(RSpec::Expectations::ExpectationNotMetError, /not equal to/)
    end
  end
end

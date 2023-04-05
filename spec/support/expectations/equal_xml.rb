# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_an_equal_xml_as do |xml2|
  match do |xml1|
    return false unless xml1.is_a?(String) && xml2.is_a?(String)

    @doc1 = Nokogiri::XML xml1
    @doc2 = Nokogiri::XML xml2

    @doc1.to_s == @doc2.to_s
  end
  failure_message do |actual|
    # :nocov:
    "#{@doc1.to_s} is not equal to \n#{@doc2.to_s}."
    # :nocov:
  end
end

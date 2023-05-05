# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_an_equal_json_as do |expected|
  attr_reader :actual, :expected

  match do |actual|
    return false unless actual.is_a?(String) && expected.is_a?(String)

    begin
      expected_json = JSON.parse(expected)
      @expected = JSON.pretty_generate(expected_json)
      actual_json = JSON.parse(actual)
      @actual = JSON.pretty_generate(actual_json)

      return actual_json == expected_json
    rescue JSON::ParserError
      return false
    end
  end

  failure_message do |actual|
    "#{@actual || actual} is not equal to \n#{@expected || expected}."
  end

  diffable
end

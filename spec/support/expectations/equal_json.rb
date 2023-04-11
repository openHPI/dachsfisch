# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :be_an_equal_json_as do |json2|
  match do |json1|
    return false unless json1.is_a?(String) && json2.is_a?(String)

    begin
      return JSON.parse(json1) == JSON.parse(json2)
    rescue JSON::ParserError
      return false
    end
  end
  failure_message do |actual|
    "#{actual} is not equal to \n#{json2}."
  end
end

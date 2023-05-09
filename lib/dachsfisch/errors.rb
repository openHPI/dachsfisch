# frozen_string_literal: true

module Dachsfisch
  class DachsfischError < StandardError; end
  class InvalidJSONInputError < DachsfischError; end
end

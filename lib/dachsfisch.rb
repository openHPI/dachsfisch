# frozen_string_literal: true

require 'nokogiri'
require 'json'

require_relative 'dachsfisch/version'
require_relative 'dachsfisch/xml2_json_converter'

module Dachsfisch
  class Error < StandardError; end
end

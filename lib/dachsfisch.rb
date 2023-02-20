# frozen_string_literal: true

require_relative 'dachsfisch/version'
require 'nokogiri'
require 'json'

module Dachsfisch
  class Error < StandardError; end

  class XML2JSONConverter
    def initialize(xml:)
      @doc = Nokogiri::XML(xml)
    end

    def perform
      root = @doc.root
      {root.name => extract_node(root)}
      # hash.to_json
    end

    def extract_node(node)
      hash = {}
      node.children.each do |child|
        if child.is_a?(Nokogiri::XML::Text)
          hash['$'] = child.text
        else
          existing_value = hash[child.name]
          new_value = extract_node(child)
          if existing_value.nil?
            hash[child.name] = new_value
          elsif existing_value.is_a? Array
            existing_value << new_value
          else
            hash[child.name] = [hash[child.name], new_value]
          end
        end
      end
      hash
    end
  end
end

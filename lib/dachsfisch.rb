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

    def extract_node(node, active_namespaces = {})
      hash = {}

      node.namespaces.each do |key, url|
        ns_key = convert_namespace_key key
        active_namespaces[ns_key] = url unless active_namespaces.key?(ns_key)
      end
      hash['@xmlns'] = active_namespaces unless active_namespaces.empty?
      node.children.each do |child|
        child_key = child.namespace&.prefix.nil? ? child.name : "#{child.namespace.prefix}:#{child.name}"
        if child.is_a?(Nokogiri::XML::Text)
          hash['$'] = child.text unless child.text.strip.empty?
        else
          existing_value = hash[child_key]
          new_value = extract_node(child, active_namespaces)
          if existing_value.nil?
            hash[child_key] = new_value
          elsif existing_value.is_a? Array
            existing_value << new_value
          else
            hash[child_key] = [hash[child_key], new_value]
          end
        end
        node.attribute_nodes.each do |attribute|
          hash["@#{attribute.name}"] = attribute.value
        end
      end
      hash
    end

    def convert_namespace_key(key)
      return '$' if key == 'xmlns'

      key[6..]
    end
  end
end

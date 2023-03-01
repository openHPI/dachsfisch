# frozen_string_literal: true

module Dachsfisch
  class XML2JSONConverter
    def initialize(xml:)
      @doc = Nokogiri::XML(xml)
    end

    def perform
      root = @doc.root
      {root.name => extract_node(root)}.to_json
    end

    def extract_node(node, active_namespaces = {})
      hash = {}
      add_namespaces_to_active_namespaces(active_namespaces, node)
      hash['@xmlns'] = active_namespaces unless active_namespaces.empty?
      node.children.each do |child|
        if child.is_a?(Nokogiri::XML::Text)
          hash['$'] = child.text unless child.text.strip.empty?
        else
          add_value_to_hash(hash, child, active_namespaces)
        end
        handle_attributes(hash, node)
      end
      hash
    end

    def convert_namespace_key(key)
      return '$' if key == 'xmlns'

      key[6..]
    end

    private

    def add_value_to_hash(hash, child, active_namespaces)
      child_key = child.namespace&.prefix.nil? ? child.name : "#{child.namespace.prefix}:#{child.name}"
      existing_value = hash[child_key]
      new_value = extract_node(child, active_namespaces)

      if existing_value.nil?
        hash[child_key] = new_value
      elsif existing_value.is_a? Array
        existing_value << new_value
      else
        hash[child_key] = [existing_value, new_value]
      end
    end

    def handle_attributes(hash, node)
      node.attribute_nodes.each do |attribute|
        hash["@#{attribute.name}"] = attribute.value
      end
    end

    def add_namespaces_to_active_namespaces(active_namespaces, node)
      node.namespaces.each do |key, url|
        ns_key = convert_namespace_key key
        active_namespaces[ns_key] = url unless active_namespaces.key?(ns_key)
      end
    end
  end
end

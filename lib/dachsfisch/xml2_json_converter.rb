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

    def extract_node(node)
      hash = {}
      active_namespaces = add_namespaces_to_active_namespaces(node)
      hash['@xmlns'] = active_namespaces unless active_namespaces.empty?
      node.children.each do |child|
        handle_content(hash, child)
        handle_attributes(hash, node)
      end
      hash
    end

    private

    def handle_content(hash, child)
      case child.class.to_s # use string representation because CData inherits Text
        when 'Nokogiri::XML::Text'
          add_text_with_custom_key(hash, child, '$')
        when 'Nokogiri::XML::Comment'
          add_text_with_custom_key(hash, child, '!', strip_text: false)
        when 'Nokogiri::XML::CDATA'
          add_text_with_custom_key(hash, child, '#', strip_text: false)
        else
          add_value_to_hash(hash, child)
      end
    end

    def add_text_with_custom_key(hash, child, base_key, strip_text: true)
      value = strip_text ? child.text.strip : child.text
      return if value.empty? && strip_text

      child_key = next_key_index hash, base_key
      hash[child_key] = value
    end

    def add_value_to_hash(hash, child)
      child_key = child.namespace&.prefix.nil? ? child.name : "#{child.namespace.prefix}:#{child.name}"
      existing_value = hash[child_key]
      new_value = extract_node(child)

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

    def add_namespaces_to_active_namespaces(node)
      node.namespaces.transform_keys {|k| convert_namespace_key(k) }
    end

    def convert_namespace_key(key)
      return '$' if key == 'xmlns'

      key.delete_prefix 'xmlns:'
    end

    def next_key_index(hash, base_key)
      key_count = hash.keys.count {|k| k.start_with? base_key }

      "#{base_key}#{key_count + 1}"
    end
  end
end

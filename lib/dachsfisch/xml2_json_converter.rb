# frozen_string_literal: true

module Dachsfisch
  class XML2JSONConverter < ConverterBase
    def initialize(xml:)
      super()
      @fragment = Nokogiri::XML::DocumentFragment.parse(xml)
      raise InvalidXMLInputError.new('input empty') if xml.nil? || xml.empty?
      raise InvalidXMLInputError.new(@fragment.errors) if @fragment.errors.length.positive?
    end

    def execute
      result = {}
      @fragment.elements.deconstruct.each do |root|
        result[node_name(root)] = extract_node(root)
      end
      result.to_json
    end

    private

    def extract_node(node)
      hash = {}
      active_namespaces = add_namespaces_to_active_namespaces(node)
      hash['@xmlns'] = active_namespaces unless active_namespaces.empty?

      handle_attributes(hash, node)
      node.children.each do |child|
        handle_content(hash, child)
      end
      hash
    end

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
      child_key = node_name(child)
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

    def node_name(node)
      node.namespace&.prefix.nil? ? node.name : "#{node.namespace.prefix}:#{node.name}"
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

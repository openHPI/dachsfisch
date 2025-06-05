# frozen_string_literal: true

module Dachsfisch
  class JSON2XMLConverter < ConverterBase
    def initialize(json:)
      super()
      @json_hash = JSON.parse json
    rescue TypeError, JSON::ParserError => e
      raise InvalidJSONInputError.new(e.message)
    end

    def execute
      fragment = Nokogiri::XML::DocumentFragment.new(Nokogiri::XML::Document.new)

      Nokogiri::XML::Builder.with fragment do |xml|
        add_element xml, @json_hash
      end
      fragment.elements.deconstruct.map(&:to_xml).join("\n")
    end

    private

    def add_element(xml, element)
      return unless element.is_a? Hash

      element['@@order']&.each do |key|
        add_node(xml, key, element[key]) unless key.start_with?('@')
      end
    end

    def add_node(xml, key, element)
      case element
        when Hash
          # underscore is used to disambiguate tag names from ruby methods
          node = xml.send(:"#{key}_") { add_element(xml, element) }
          handle_attribute_and_namespaces(node, element)
        when Array
          element.each do |sub_element|
            add_node xml, key, sub_element
          end
        else
          add_text_node(xml, element, key[0])
      end
    end

    def handle_attribute_and_namespaces(node, element)
      element.keys.filter {|element_key| element_key.start_with?(/@[^@]/) }.each do |attribute_key|
        if attribute_key.start_with? '@xmlns'
          element[attribute_key].each do |namespace_key, namespace|
            # add namespace of current scope to node. The root-ns($) gets 'xmlns' as key, named namespaces 'xmlns:name' respectively.
            node["xmlns#{":#{namespace_key}" unless namespace_key == '$'}"] = namespace
          end
        else
          node[attribute_key.delete_prefix('@')] = element[attribute_key]
        end
      end
    end

    def add_text_node(xml, element, type)
      case type
        when '!'
          xml.comment element
        when '#'
          xml.cdata element
        when '$'
          xml.text element
      end
    end
  end
end

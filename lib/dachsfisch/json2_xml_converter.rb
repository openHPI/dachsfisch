# frozen_string_literal: true

module Dachsfisch
  class JSON2XMLConverter
    def initialize(json:)
      @json_hash = JSON.parse json
      @namespaces = {}
    end

    def perform
      Nokogiri::XML::Builder.new do |xml|
        add_element xml, @json_hash

        @namespaces.each do |namespace_key, namespace|
          xml.doc.root[namespace_key] = namespace
        end
      end.to_xml
    end

    private

    def add_element(xml, element)
      return unless element.is_a? Hash

      element.each do |key, value|
        add_node(xml, key, value) unless key.start_with?('@')
      end
    end

    def add_node(xml, key, element)
      case element
        when Hash
          node = xml.send(key) { add_element(xml, element) }
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
      element.keys.filter {|element_key| element_key.start_with?('@') }.each do |attribute_key|
        if attribute_key.start_with? '@xmlns'
          element[attribute_key].each do |namespace_key, namespace|
            # add present namespaces to the list. The root-ns($) gets 'xmlns' as key, named namespaces 'xmlns:name' respectively.
            @namespaces["xmlns#{namespace_key == '$' ? '' : ":#{namespace_key}"}"] = namespace
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

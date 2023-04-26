# frozen_string_literal: true

module Dachsfisch
  class JSON2XMLConverter
    def initialize(json:)
      @json_hash = JSON.parse json
    end

    def add_element(xml, element)
      return unless element.is_a? Hash

      @namespaces = {}
      element.each do |key, value|
        add_node(xml, key, value) unless key == '@xmlns'
      end
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

    def add_node(xml, key, element)
      case element
      when Hash
        node = create_node(element, key, xml)
        element.keys.filter { |element_key| element_key.start_with?('@') }.each do |attribute_key|
          if attribute_key.start_with? '@xmlns'

            element[attribute_key].each do |namespace_key, namespace|
              @namespaces["xmlns#{namespace_key == '$' ? '' : ":#{namespace_key}"}"] = namespace
            end
          else
            node[attribute_key.delete_prefix('@')] = element[attribute_key]
          end

        end
      when Array
        element.each do |sub_element|
          add_node xml, key, sub_element
        end
      end
    end

    def create_node(element, key, xml)
      if element.keys.include?('$')
        return xml.send(key, element['$'])
      end

      xml.send(key) { add_element(xml, element) }
    end
  end
end

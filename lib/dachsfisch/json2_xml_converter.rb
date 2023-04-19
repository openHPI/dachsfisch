# frozen_string_literal: true

module Dachsfisch
  class JSON2XMLConverter
    def initialize(json:)
      # @json = json
      @json_hash = JSON.parse json
    end

    def add_element(xml, element)
      return unless element.is_a? Hash

      element.each do |key, value|
        add_node(xml, key, value)
      end
    end

    def perform
      Nokogiri::XML::Builder.new do |xml|
        add_element xml, @json_hash
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
              node["xmlns#{namespace_key == '$' ? '' : ":#{namespace_key}"}"] = namespace
            end
          else
            node[attribute_key.delete_prefix('@')] = element[attribute_key]
          end
        end
      when Array
        element.each do |sub_element|
          add_node xml, key, sub_element
          # xml.send(ns_key) { add_element(xml, sub_element) }
        end
      else
        raise "WTF #{element} is a #{element.class}" # deleteme
      end
    end

    def create_node(element, key, xml)
      return xml.send(key, element['$']) if element.keys.include?('$')

      xml.send(key) { add_element(xml, element) }
    end
  end
end

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

      # if element.is_a? Array
      #
      # end
      # if element[0].is_a? String
      #   add_node(xml, element)
      # else
      #   element.each do |child_element|
      #     add_node(xml, child_element)
      #   end
      # end
    end

    def perform
      Nokogiri::XML::Builder.new do |xml|
        # xml.alice {
        #   xml.bob 'charlie'
        #   xml.bob 'david'
        # }
        # @json_hash.each do |element|
        #   add_element xml, element
        # end
        add_element xml, @json_hash
      end.to_xml
    end

    private

    def add_node(xml, key, element)
      case element
      when Hash
        return xml.send(key, element['$']) if element.keys.include?('$')

        xml.send(key) { add_element(xml, element) }
      when Array
        element.each do |sub_element|
          add_node xml, key, sub_element
          # xml.send(key) { add_element(xml, sub_element) }
        end
      else
        raise "WTF #{element} is a #{element.class}"
      end
    end
  end
end

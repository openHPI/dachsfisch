# frozen_string_literal: true

require 'rspec/expectations'

RSpec::Matchers.define :have_equal_namespace_definitions_as do |expected|
  attr_reader :actual, :expected

  match do |actual|
    return false unless actual.is_a?(String) && expected.is_a?(String)

    expected_xml = parse_fragment(expected)
    @expected = expected_xml.to_xml
    actual_xml = parse_fragment(actual)
    @actual = actual_xml.to_xml

    return false if expected_xml.errors.length.positive? || actual_xml.errors.length.positive?
    return false unless EquivalentXml.equivalent?(expected_xml, actual_xml)

    return compare_namespaces(actual_xml.children.first, expected_xml.children.first)
  end

  failure_message do |actual|
    "#{@actual || actual} does not have equal namespaces as \n#{@expected || expected}."
  end

  diffable

  private

  def compare_namespaces(actual, expected)
    return false unless same_namespace_definitions?(actual, expected)

    actual.children.each_with_index.all? do |actual_child, index|
      expected_child = expected.children[index]
      compare_namespaces(actual_child, expected_child)
    end
  end

  def same_namespace_definitions?(actual, expected)
    return true if actual.nil? && expected.nil?
    return false if actual.nil? || expected.nil?

    actual_namespaces = namespaces(actual)
    expected_namespaces = namespaces(expected)
    actual_namespaces == expected_namespaces
  end

  def namespaces(node)
    node.namespace_definitions.map {|namespace| namespace.deconstruct_keys(%i[prefix href]) }.sort_by {|ns| ns[:prefix].to_s }
  end

  def parse_fragment(xml)
    # This is a workaround for an unintended behavior in Nokogiri's XML::DocumentFragment.parse method.
    # Originally, the method de-duplicates the namespace definitions of all nodes in the fragment, if possible.
    # However, for this test, we want to compare the namespace definitions of the actual and expected XML.
    # Therefore, we parse the XML with a root node, and compare the resulting document.
    Nokogiri::XML::Document.parse("<root>#{xml}</root>", &:noblanks)
  end
end

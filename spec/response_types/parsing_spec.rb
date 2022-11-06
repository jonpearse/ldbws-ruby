require "spec_helper"

describe Ldbws::ResponseTypes::Base do
  def parse_xml(xmlstr)
    Nokogiri::XML::DocumentFragment.parse(xmlstr).children.first
  end

  context "simple parsing" do
    class Test < Ldbws::ResponseTypes::Base
      property :foo, String
      collection :bar, "value", String
    end

    it "parses correctly when all values are present" do
      xml = parse_xml("<test><foo>Content of foo</foo><bar><value>Bar 1</value><value>Bar 2</value></bar></test>")
      example = Test.from_xml(xml)

      expect(example.foo).to eq("Content of foo")
      expect(example.bar.length).to eq(2)
      expect(example.bar.join(",")).to eq("Bar 1,Bar 2")
    end

    it "correctly handles empty collections" do
      xml = parse_xml("<test><foo>Content of foo</foo><bar/></test>")
      example = Test.from_xml(xml)

      expect(example.foo).to eq("Content of foo")
      expect(example.bar.length).to eq(0)
    end

    it "correctly handles missing collections" do
      xml = parse_xml("<test><foo>Content of foo</foo></test>")
      example = Test.from_xml(xml)

      expect(example.foo).to eq("Content of foo")
      expect(example.bar.length).to eq(0)
    end

    it "correctly handles empty nodes" do
      xml = parse_xml("<test><foo/></test>")
      example = Test.from_xml(xml)

      expect(example.foo).to be_nil
    end
  end
end

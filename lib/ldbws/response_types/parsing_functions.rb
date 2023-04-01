module Ldbws::ResponseTypes # :nodoc:
  # Provides a DSL-type interface for easily defining the conversion from XML to PORO.
  #
  # It does this through the provision of two methods: {#property}, which defines a single property of a specified type,
  # and {#collection} which defines a list of the same.
  #
  # Thus, given some XML like:
  #
  #   <foo>text</foo>
  #   <bar>
  #     <value>one</value>
  #     <value>two</value>
  #     <value>three</value>
  #   </bar>
  #
  # Your DSL would look something like:
  #
  #   property :foo, String
  #   collection :bar, "Value", String
  #
  # === Nested parsing
  #
  # Both [#property] and [#collection] take a class that is used to convert from the XML value to Ruby. This can be
  # any normal Ruby class that response to either +#new+ or +#parse+ (like [Date]).
  # Additionally, this can be another class implementing this module, in which case the #from_xml method is used.
  module ParsingFunctions # :nodoc:
    def self.included(base)
      base.extend(ClassFunctions)
    end

    module ClassFunctions # :nodoc:
      # Creates an object from an XML node.
      #
      # === Parameters
      # xml_node:: the {XML node}[rdoc-ref:Nokogiri:XML::Node] to parse
      def from_xml(xml_node)
        raise "Oh no" if properties.empty?

        props = properties.dup.map do |key, defn|
          # look for the node, and return the default if we can’t find it
          found = xml_node.xpath("./#{defn[:selector]}")
          next [key, defn[:default]] unless found.any?

          [
            key,
            if defn[:collection]
              found.map { |node| parse_property(node, defn) }.compact
            else
              parse_property(found.first, defn)
            end,
          ]
        end.to_h

        new(props)
      end

      protected

      # Defines a single property to be parsed from the XML.
      #
      # === Examples
      #
      # Given the structure
      #
      #   <foo>text content</foo>
      #   <bar>3.1415</bar>
      #   <blah>Some more content</blah>
      #
      # and
      #
      #   property :foo, String
      #   property :bar, Float
      #   property :baz, String, selctor: "blah" # selects the value from <blah>, but stores it as `:baz`
      #
      # === Parameters
      # key:: the name of the property. This us used to select the node in XML unless `:selector` is specified.
      # klass:: the Ruby class to use when parsing the value.
      # selector:: an optional XPath selector. If not specified, a snake_case version of `:key` is used instead.
      # default:: an optional default value for the property if the specified XML node cannot be found.
      def property(key, klass, selector: nil, default: nil)
        selector ||= Ldbws::Utils.to_snake_case(key.to_s)

        @_properties ||= {}
        @_properties[key] = {
          key: key,
          selector: selector,
          klass: klass,
          default: default,
          collection: false,
        }
      end

      # Defines an array of a single type to be parsed from the XML.
      #
      # === Examples
      #
      # Given the structure
      #
      #   <foo>
      #     <value>…</value>
      #     <value>…</value>
      #   </foo>
      #
      # and
      #
      #   property :foo, "value", String
      #   property :bar, "value", String, selector: "foo" # selects the same as above, just aliased as :bar
      #
      # === Parameters
      # key:: the name of the property. This us used to select the node in XML unless +:selector+ is specified.
      # option_selector:: a selector for the ‘child’ node that contains the additional value
      # klass:: the Ruby class to use when parsing the value.
      # selector:: an optional XPath selector to use when getting the ‘root’ node. If left unspecified, a +snake_case+
      #            version of +:key+ is used.
      # default:: an optional default value, if the specified XML node cannot be found.
      def collection(key, option_selector, klass, selector: nil, default: [])
        selector ||= Ldbws::Utils.to_snake_case(key.to_s)

        @_properties ||= {}
        @_properties[key] = {
          key: key,
          selector: "#{selector}/#{option_selector}",
          klass: klass,
          default: default,
          collection: true,
        }
      end

      # Used by #inherited to copy properties from parents to children
      def properties=(props) # :nodoc:
        @_properties = props
      end

      private

      # Returns the properties
      def properties
        @_properties
      end

      def inherited(sub)
        sub.properties = @_properties.dup
      end

      def parse_property(xml_node, definition)
        return definition[:default] if xml_node.children.empty?

        klass = definition[:klass]
        content = xml_node.content

        if klass.respond_to?(:parse)
          klass.parse(content)
        elsif klass.respond_to?(:from_xml)
          klass.from_xml(xml_node)
        elsif klass.respond_to?(:new)
          klass.new(content)
        else
          content
        end
      end
    end
  end

  # Provides a Boolean type for use with the DSL.
  class Boolean # :nodoc:
    def self.parse(value)
      value.downcase == "true"
    end
  end

  # Provides a self-stripping string for use with the DSL.
  class StrippedString # :nodoc:
    def self.parse(value)
      value.strip
    end
  end
end

module Ldbws::ResponseTypes
  module ParsingFunctions
    def self.included(base)
      base.extend(ClassFunctions)
    end

    module ClassFunctions
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

      def properties=(props)
        @_properties = props
      end

      private

      def properties
        @_properties
      end

      def inherited(sub)
        sub.properties = @_properties.dup
      end

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

  class Boolean
    def self.parse(value)
      value.downcase == "true"
    end
  end

  class StrippedString
    def self.parse(value)
      value.strip
    end
  end
end

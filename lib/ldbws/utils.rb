# Utility functions for use within the library.
module Ldbws
  module Utils # :nodoc: all
    # Upcases the first letter of the passed string.
    #
    # === Parameters
    # str:: the input string
    def self.ucfirst(str)
      str[0].upcase + str[1..]
    end

    # Converts the passed string from CamelCase to snake_case
    #
    # === Parameters
    # str:: the input string
    # ucfirst:: [Boolean] whether or not to call [#ucfirst] as well
    def self.to_snake_case(str, ucfirst = false)
      output = str.to_s.gsub(/_([a-z])/) { $1.upcase }

      ucfirst ? ucfirst(output) : output
    end

    # Deep converts a passed object as a hash.
    #
    # === Parameters
    # value:: the value to convert
    def self.deep_hashify_value(value)
      if value.nil?
        nil
      elsif value.is_a?(Array)
        value.map { |v| deep_hashify_value(v) }
      elsif value.respond_to?(:to_h)
        value.to_h
      else
        value
      end
    end

    # Deep-serialises a hash to XML using Nokogiri
    #
    # === Parameters
    # xml:: the instance of Nokogiri to build within
    # hsh:: the hash to serialise
    def self.deep_to_soap(xml, hsh)
      hsh.each do |key, value|
        key = to_snake_case(key)

        if value.is_a?(Hash)
          xml.send(key) { deep_to_soap(xml, value) }
        elsif value.is_a?(Array)
          xml.send(key) {
            value.each { |v| deep_to_soap(xml, v) }
          }
        else
          xml.send(key, value)
        end
      end
    end
  end
end

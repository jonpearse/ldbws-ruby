require "nokogiri"

require "ldbws/utils"

module Ldbws
  module SoapHelper
    def self.to_soap(token, root_node, params)
      Nokogiri::XML::Builder.new do |xml|
        xml.Envelope(xmlns: "http://schemas.xmlsoap.org/soap/envelope/") {
          xml.Header {
            xml.AccessToken(xmlns: "http://thalesgroup.com/RTTI/2013-11-28/Token/types") {
              xml.TokenValue token
            }
          }
          xml.Body {
            xml.send("#{root_node}Request", xmlns: "http://thalesgroup.com/RTTI/2021-11-01/ldb/") {
              deep_to_xml(xml, params.to_soap_params)
            }
          }
        }
      end.to_xml
    end

    def self.from_soap(xmlstr, root_node, response_xpath)
      xml = Nokogiri::XML(xmlstr)
      xml.remove_namespaces!

      xml.xpath("//#{root_node}Response//#{response_xpath}").first
    end

    private

    def self.deep_to_xml(xml, hsh)
      hsh.each do |key, value|
        key = Utils.to_snake_case(key)

        if value.is_a?(Hash)
          xml.send(key) { deep_to_xml(xml, value) }
        elsif value.is_a?(Array)
          xml.send(key) {
            value.each { |v| deep_to_xml(xml, v) }
          }
        else
          xml.send(key, value)
        end
      end
    end
  end
end

require "dry-schema"

require "ldbws/utils"

module Ldbws::Request
  module Types
    include Dry.Types()

    Crs = String.constrained(size: 3)
    FilterType = String.enum("to", "from")
  end

  class Base
    def initialize(args)
      params = self.class::SCHEMA.(args)
      raise ParamValidationError.new(params.errors) if params.errors.any?

      @params = params.to_h
    end

    # Returns a (nested) hash that can be turned into SOAP
    def to_soap(xml)
      Ldbws::Utils.deep_to_soap(xml, to_soap_params)
    end

    #
    def from_soap(xml)
      result_node = xml.xpath(self.class::RESULT_XPATH).first
      raise "Oh no" unless result_node

      self.class::RESULT_TYPE.from_xml(result_node)
    end

    protected

    def to_soap_params
      @params
    end
  end

  class ParamValidationError < RuntimeError; end
end

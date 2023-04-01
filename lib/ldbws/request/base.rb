require "dry-schema"
require "nokogiri"

require "ldbws/utils"

# This module defines specific request types that map 1:1 with corresponding types in the LDBWS service schema. Sadly
# these are not especially well-documented.
module Ldbws::Request # :nodoc:
  # Common schema types for use when validating.
  module Types # :nodoc:
    include Dry.Types()

    # A CRS code (eg ‘WAT’ for London Waterloo). These are not exhaustively validated.
    Crs = String.constrained(size: 3)

    # A specific type used when filtering by CRS.
    FilterType = String.enum("to", "from")
  end

  # \Base request type used whem querying LDBWS: provides basic functionality that can be overridden on a per-subclass
  # basis.
  class Base # :nodoc:
    # Creates a Request object given the specified arguments. This performs validation accordng to the request’s schema,
    # and throws ParamValidationError on failure.
    #
    # === Parameters
    #
    # args:: a {Hash} cotaining the request’s parameters
    def initialize(args)
      params = self.class::SCHEMA.(args)
      raise ParamValidationError.new(params.errors) if params.errors.any?

      @params = params.to_h
    end

    # Builds a SOAP request corresponding to the current request.
    #
    # === Parameters
    # xml:: the {Nokogiri Builder}[rdoc-ref:Nokogiri::XML::Builder] object to append XML to.
    def to_soap(xml)
      Ldbws::Utils.deep_to_soap(xml, to_soap_params)
    end

    # Parses the returned SOAP response and converts it into the corresponding {response type}[rdoc-ref:ResponseTypes],
    # defined in `RESULT_TYPE`.
    #
    # === Parameters
    # xml:: the {XML node}[rdoc-ref:Nokogiri::XML::Node] that should contain the response to this request.
    def from_soap(xml)
      result_node = xml.xpath(self.class::RESULT_XPATH).first
      unless result_node
        raise Ldbws::ResponseParsingError("Root node not found (#{self.class::RESULT_XPATH})")
      end

      self.class::RESULT_TYPE.from_xml(result_node)
    end

    protected

    # Converts the inbound request parameters into something that can be serialised to SOAP, allow per-subclass to
    # provide specific functionality.
    #
    # :yield: a [Hash] of parameters for serialisation to SOAP.
    def to_soap_params
      @params
    end
  end

  # Raised when an error occurs when validating request parameters. Messages are passed through directly from
  # {dry-schema}[https://dry-rb.org/gems/dry-schema/1.10/].
  class ParamValidationError < RuntimeError
    def initialize(messages) # :nodoc:
      @messages = messages.to_h
    end

    # Returns the validation error messages as a hash.
    def messages
      @messages
    end
  end
end

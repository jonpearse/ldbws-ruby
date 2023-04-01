require "ldbws/utils"

require "ldbws/response_types/parsing_functions"

# This module defines specific response types that map 1:1 with corresponding types in the LDBWS service schema. Sadly
# these are not especially well-documented.
#
# A lot of the Ruby side here works using a DSL to programatically define how XML nodes should be converted into Ruby
# objects: this is defined in {ParsingFunctions}.
module Ldbws::ResponseTypes # :nodoc:
  # \Base class which defines most of the functionality required by subclasses.
  class Base # :nodoc:
    include ParsingFunctions

    def method_missing(prop)
      @props.fetch(prop)
    end

    def to_h
      @props.to_h do |k, v|
        [
          k,
          Ldbws::Utils.deep_hashify_value(v),
        ]
      end
    end

    private

    def initialize(props)
      @props = props
    end
  end
end

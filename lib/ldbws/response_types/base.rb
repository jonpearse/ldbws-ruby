require "ldbws/utils"

require "ldbws/response_types/parsing_functions"

module Ldbws::ResponseTypes
  class Base
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

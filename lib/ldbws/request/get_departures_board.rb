require "ldbws/request/base"

require "ldbws/response_types/departures_board"

module Ldbws::Request
  class GetDeparturesBoard < Base
    SCHEMA = Dry::Schema.Params do
      required(:crs).filled(Types::Crs)
      required(:filter_list).array(Types::Crs, min_size?: 1)
      optional(:time_offset).filled(:integer)
      optional(:time_window).filled(:integer)
    end

    RESULT_XPATH = "DeparturesBoard"

    # :nodoc:
    RESULT_TYPE = Ldbws::ResponseTypes::DeparturesBoard

    def to_soap_params
      @params.tap do |params|
        params[:crs].upcase!
        params[:filter_list].map! do |value|
          { crs: value.upcase }
        end
      end
    end
  end

  class GetDeparturesBoardWithDetails < GetDeparturesBoard
    RESULT_TYPE = Ldbws::ResponseTypes::DeparturesBoardWithDetails
  end
end

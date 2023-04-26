require "ldbws/request/base"

require "ldbws/response_types/departures_board"

module Ldbws::Request
  # Requests a departure board for a station, filtered by departures to one or many other stations. Corresponds to
  # +GetDeparturesBoardRequest+ in the LDBWS schema.
  #
  # === Parameters
  # crs:: the CRS code of the station you wish to get departures for (required).
  # filter_list:: a list of CRS codes to filter departures (required).
  # time_offset:: the offset from the current time—in minutes—to return departure information (optional).
  # time_window:: how far into the future—relative to +:time_offset+—to return service information for (optional).
  class GetDeparturesBoard < Base
    # :nodoc:
    SCHEMA = Dry::Schema.Params do
      config.validate_keys = true

      required(:crs).filled(Types::Crs)
      required(:filter_list).array(Types::Crs, min_size?: 1)
      optional(:time_offset).filled(:integer)
      optional(:time_window).filled(:integer)
    end

    # :nodoc:
    RESULT_XPATH = "DeparturesBoard"

    # :nodoc:
    RESULT_TYPE = Ldbws::ResponseTypes::DeparturesBoard

    protected

    # :nodoc:
    def to_soap_params
      @params.tap do |params|
        params[:crs].upcase!
        params[:filter_list].map! do |value|
          { crs: value.upcase }
        end
      end
    end
  end

  # Requests a departure board for a statuion, filtered by departures to one or more other stations. This returns more
  # information than GetDepartureBoard.
  #
  # This corresponds to +GetDeparturesBoardWithDetailsRequest+ in the LDBWS schema.
  #
  # === Parameters
  # crs:: the CRS code of the station you wish to get departures for (required).
  # filter_list:: a list of CRS codes to filter departures (required).
  # time_offset:: the offset from the current time—in minutes—to return departure information (optional).
  # time_window:: how far into the future—relative to +:time_offset+—to return service information for (optional).
  class GetDeparturesBoardWithDetails < GetDeparturesBoard
    # :nodoc:
    RESULT_TYPE = Ldbws::ResponseTypes::DeparturesBoardWithDetails
  end
end

require "ldbws/request/base"

require "ldbws/response_types/station_board"

module Ldbws::Request
  # Returns an arrival or departure board for a given station. Corresponds to +GetStationBoardRequest+ in the LDBWS
  # schema.
  #
  # === Parameters
  # crs:: the CRS code for the station (required)
  # num_rows:: the number of services to include (optional)
  # filter_crs:: a CRS code for a station to filter arrivals from/departures to (optional)
  # filter_type:: either ‘to’ or ‘from’ (optional)
  # time_offset:: the offset from the current time—in minutes—to return departure information (optional).
  # time_window:: how far into the future—relative to +:time_offset+—to return service information for (optional).
  class GetStationBoard < Base
    # :nodoc:
    SCHEMA = Dry::Schema.Params do
      config.validate_keys = true

      required(:crs).filled(Types::Crs)
      optional(:num_rows).filled(:integer)
      optional(:filter_crs).filled(Types::Crs)
      optional(:filter_type).filled(Types::String.enum("to", "from"))
      optional(:time_offset).filled(:integer)
      optional(:time_window).filled(:integer)
    end

    # :nodoc:
    RESULT_XPATH = "GetStationBoardResult"

    # :nodoc:
    RESULT_TYPE = Ldbws::ResponseTypes::StationBoard

    def initialize(args)
      # there doesn’t seem to be a nice way of getting Dry::Types to do a case-insensitive enum, so instead we’ll do
      # some manual case-coersion here
      args[:filter_type].downcase! if args[:filter_type]

      super(args)
    end

    protected

    # :nodoc:
    def to_soap_params
      @params.tap do |params|
        # CRSes should always be upcased
        params[:crs].upcase!
        params[:filter_crs].upcase! if params[:filter_crs]
        params[:filter_type].downcase! if params[:filter_type]

        # filter type isn’t needed if we’re not filtering
        params.delete(:filter_type) unless params[:filter_crs]
      end
    end
  end

  # Returns an arrival or departure board for a given station with full service details. Corresponds to
  # +GetStationBoardWithDetailsRequest+ in the LDBWS schema.
  #
  # === Parameters
  # crs:: the CRS code for the station (required)
  # num_rows:: the number of services to include (optional)
  # filter_crs:: a CRS code for a station to filter arrivals from/departures to (optional)
  # filter_type:: either ‘to’ or ‘from’ (optional)
  # time_offset:: the offset from the current time—in minutes—to return departure information (optional).
  # time_window:: how far into the future—relative to +:time_offset+—to return service information for (optional).
  class GetStationBoardWithDetails < GetStationBoard
    # :nodoc:
    RESULT_TYPE = Ldbws::ResponseTypes::StationBoardWithDetails
  end
end

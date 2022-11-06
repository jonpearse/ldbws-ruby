require "ldbws/request/base"

require "ldbws/response_types/station_board"

module Ldbws::Request
  class GetStationBoard < Base
    SCHEMA = Dry::Schema.Params do
      required(:crs).filled(Types::Crs)
      optional(:num_rows).filled(:integer)
      optional(:filter_crs).filled(Types::Crs)
      optional(:filter_type).filled(Types::FilterType)
      optional(:time_offset).filled(:integer)
      optional(:time_window).filled(:integer)
    end

    RESULT_XPATH = "GetStationBoardResult"

    RESULT_TYPE = Ldbws::ResponseTypes::StationBoard

    def to_soap_params
      @params.tap do |params|
        # CRSes should always be upcased
        params[:crs].upcase!
        params[:filter_crs].upcase! if params[:filter_crs]

        # filter type isn’t needed if we’re not filtering
        params.delete(:filter_type) unless params[:filter_crs]
      end
    end
  end

  class GetStationBoardWithDetails < GetStationBoard
    RESULT_TYPE = Ldbws::ResponseTypes::StationBoardWithDetails
  end
end

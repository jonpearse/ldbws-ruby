require "ldbws/response_types/base"
require "ldbws/response_types/station_board"

module Ldbws::ResponseTypes
  class DepartureItem < Base
    property :crs, String, selector: "@crs"
    property :service, ServiceItem
  end

  class DepartureItemWithDetails < Base
    property :crs, String, selector: "@crs"
    property :service, ServiceItemWithCallingPoints
  end

  #

  class DeparturesBoard < BaseStationBoard
    collection :departures, "destination", DepartureItem
  end

  class DeparturesBoardWithDetails < BaseStationBoard
    collection :departures, "destination", DepartureItemWithDetails
  end
end

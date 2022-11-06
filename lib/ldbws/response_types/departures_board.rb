require "ldbws/response_types/base"
require "ldbws/response_types/station_board"

module Ldbws::ResponseTypes
  # Represents an item on a departure board.
  #
  # === Properties
  # crs:: the CRS for the item
  # service:: a ServiceItem[rdoc-ref:ServiceItem] representing this service.
  class DepartureItem < Base
    property :crs, String, selector: "@crs"
    property :service, ServiceItem
  end

  # Represents an item on a departure board with additional details.
  #
  # === Properties
  # crs:: the CRS for the item
  # service:: a ServiceItemWithCallingPoints[rdoc-ref:ServiceItemWithCallingPoints] representing this service.
  class DepartureItemWithDetails < Base
    property :crs, String, selector: "@crs"
    property :service, ServiceItemWithCallingPoints
  end

  # Represents a departures board.
  #
  # === Properties
  # departures:: a list of departures[rdoc-ref:DepartureItem].
  class DeparturesBoard < BaseStationBoard
    collection :departures, "destination", DepartureItem
  end

  # Represents a departures board with additional details.
  # === Properties
  # departures:: a list of departures[rdoc-ref:DepartureItemWithDetails].
  class DeparturesBoardWithDetails < BaseStationBoard
    collection :departures, "destination", DepartureItemWithDetails
  end
end

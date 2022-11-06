require "ldbws/response_types/base"
require "ldbws/response_types/service_item"

module Ldbws::ResponseTypes
  class BaseStationBoard < Base
    property :generated_at, DateTime
    property :location_name, String
    property :crs, String
    collection :nrcc_messages, "message", StrippedString
    property :platform_available, Boolean, default: false
    property :are_services_available, Boolean, default: true
  end

  class StationBoard < BaseStationBoard
    collection :train_services, "service", ServiceItem
    collection :bus_services, "service", ServiceItem
    collection :ferry_services, "service", ServiceItem
  end

  class StationBoardWithDetails < BaseStationBoard
    collection :train_services, "service", ServiceItemWithCallingPoints
    collection :bus_services, "service", ServiceItemWithCallingPoints
    collection :ferry_services, "service", ServiceItemWithCallingPoints
  end
end

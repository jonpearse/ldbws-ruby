require "ldbws/response_types/base"
require "ldbws/response_types/service_item"

module Ldbws::ResponseTypes
  # \Base station board information. This does not directly correspond to a type in LDBWS.
  #
  # === Properties
  # generated_at::
  # location_name::
  # crs::
  # nrcc_messages::
  # platform_available::
  # are_services_available::
  class BaseStationBoard < Base
    property :generated_at, DateTime
    property :location_name, String
    property :crs, String
    collection :nrcc_messages, "message", StrippedString
    property :platform_available, Boolean, default: false
    property :are_services_available, Boolean, default: true
  end

  # Represents a station arrival/departure board in LDBWS.
  #
  # === Properties
  # As BaseStationBoard, and additionally:
  #
  # train_services::
  # bus_services::
  # ferry_services::
  class StationBoard < BaseStationBoard
    collection :train_services, "service", ServiceItem
    collection :bus_services, "service", ServiceItem
    collection :ferry_services, "service", ServiceItem
  end

  # Represents a station arrival/departure board with additional details in LDBWS.
  #
  # === Properties
  # As BaseStationBoard, and additionally:
  #
  # train_services::
  # bus_services::
  # ferry_services::
  class StationBoardWithDetails < BaseStationBoard
    collection :train_services, "service", ServiceItemWithCallingPoints
    collection :bus_services, "service", ServiceItemWithCallingPoints
    collection :ferry_services, "service", ServiceItemWithCallingPoints
  end
end

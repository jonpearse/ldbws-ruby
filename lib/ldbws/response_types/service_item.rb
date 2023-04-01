require "ldbws/response_types/base"
require "ldbws/response_types/calling_point"

module Ldbws::ResponseTypes
  class Location < Base
    property :name, String, selector: "locationName"
    property :crs, String
    property :via, String
  end

  #

  class ServiceItem < Base
    property :sta, Time
    property :eta, String
    property :std, Time
    property :etd, String
    property :platform, String
    property :operator, String
    property :operator_code, String
    property :circular_route, Boolean, default: false, selector: "isCircularRoute"
    property :cancelled, Boolean, default: false, selector: "isCancelled"
    property :service_type, String
    property :length, Integer
    property :detach_front, Boolean, default: false
    property :reverse_formation, Boolean, default: false, selector: "isReverseFormation"
    property :cancel_reason, String
    property :delay_reason, String
    property :service_id, String, selector: "serviceID"
    collection :adhoc_alerts, "adhocAlertText", String
    collection :origin, "location", Location
    collection :destination, "location", Location
  end

  class ServiceItemWithCallingPoints < ServiceItem
    collection :previous_calling_points, "callingPointList/callingPoint", CallingPoint
    collection :subsequent_calling_points, "callingPointList/callingPoint", CallingPoint
  end
end

require "ldbws/response_types/base"

module Ldbws::ResponseTypes
  class CallingPoint < Base
    property :location_name, String
    property :crs, String
    property :st, Time
    property :et, String
    property :at, String
    property :cancelled, Boolean, selector: "isCancelled"
    property :length, Integer
    property :detatch_front, Boolean, default: false
    collection :adhoc_alerts, "adhocAlertText", String
    property :cancel_reason, String
    property :delay_reason, String
    property :affected_by_diversion, Boolean, default: false
    property :reroute_delay, Integer, default: 0
    property :affected_by, String
  end
end

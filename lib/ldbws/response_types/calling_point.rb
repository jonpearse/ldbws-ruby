require "ldbws/response_types/base"
require "ldbws/response_types/formation"

module Ldbws::ResponseTypes
  # Represents a calling point in the LDBWS.
  #
  # === Properties
  # location_name:: the name of the station
  # crs:: the CRS of the station
  # st:: the scheduled time (as a Time object)
  # et:: the expected time (as a String)
  # at:: the actual time (as a string)
  # cancelled::
  # length::
  # detatch_front::
  # formation:: information about the formation of the train
  # adhoc_alerts::
  # cancel_reason::
  # delay_reason::
  # affected_by_diversion::
  # reroute_delay::
  # affected_by::
  class CallingPoint < Base
    property :location_name, String
    property :crs, String
    property :st, Time
    property :et, String
    property :at, String
    property :cancelled, Boolean, selector: "isCancelled"
    property :length, Integer
    property :detatch_front, Boolean, default: false
    property :formation, Formation
    collection :adhoc_alerts, "adhocAlertText", String
    property :cancel_reason, String
    property :delay_reason, String
    property :affected_by_diversion, Boolean, default: false
    property :reroute_delay, Integer, default: 0
    property :affected_by, String
  end
end

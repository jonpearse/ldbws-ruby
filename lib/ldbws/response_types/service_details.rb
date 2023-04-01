require "ldbws/response_types/base"
require "ldbws/response_types/formation"

module Ldbws::ResponseTypes
  # Represents details about a service in LDBWS.
  #
  # === Properties
  # generatedAt::
  # service_type::
  # location_name::
  # crs::
  # operator::
  # operator_code::
  # rsid::
  # cancelled::
  # cancel_reason::
  # delay_reason::
  # overdue_message::
  # length::
  # detach_front::
  # reverse_formation::
  # platform::
  # sta:: the scheduled arrival time as a Time object.
  # eta:: the estimated arrival time, as a string
  # ata:: the actual arrival time, as a string
  # std:: the scheduled departure time as a Time object
  # etd:: the estimated departure time, as a string
  # atd:: the actual departure time, as a String
  # diverted_via::
  # diversion_reason::
  # adhoc_alerts::
  # formation:: information about the formation of the train
  # previous_calling_points::
  # subsequent_calling_points::
  class ServiceDetails < Base
    # from rtti_2017-10-01_ldb_types.xsd // BaseServiceDetails
    property :generated_at, DateTime
    property :service_type, String
    property :location_name, String
    property :crs, String
    property :operator, String
    property :operator_code, String
    property :rsid, String
    property :cancelled, Boolean, selector: "isCancelled", default: false
    property :cancel_reason, String
    property :delay_reason, String
    property :overdue_message, String
    property :length, Integer
    property :detach_front, Boolean, default: false
    property :reverse_formation, Boolean, selector: "isReverseFormation", default: false
    property :platform, String
    property :sta, Time
    property :eta, String
    property :ata, String
    property :std, Time
    property :etd, String
    property :atd, String

    # From rtti_2021-11-01_ldb_types.xsd // BaseServiceDetails
    property :diverted_via, String
    property :diversion_reason, String

    # From rtti_2021-11-01_ldb_types.xsd // ServiceDetails
    collection :adhoc_alerts, "adhocAlertText", String
    property :formation, Formation
    collection :previous_calling_points, "callingPointList/callingPoint", CallingPoint
    collection :subsequent_calling_points, "callingPointList/callingPoint", CallingPoint
  end
end

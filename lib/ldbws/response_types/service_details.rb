require "ldbws/response_types/base"

module Ldbws::ResponseTypes
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
    collection :previous_calling_points, "callingPointList/callingPoint", CallingPoint
    collection :subsequent_calling_points, "callingPointList/callingPoint", CallingPoint
  end
end

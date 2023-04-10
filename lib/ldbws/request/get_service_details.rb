require "ldbws/request/base"

require "ldbws/response_types/service_details"

module Ldbws::Request
  # Returns details about a particular service. Corresponds to +GetServiceDetailsResponse+ in the LDBWS schema.
  #
  # === Parameters
  # service_id:: the ID of the service (required)
  class GetServiceDetails < Base
    # :nodoc:
    SCHEMA = Dry::Schema.Params do
      config.validate_keys = true

      required(:service_id).filled(:string)
    end

    # :nodoc:
    RESULT_XPATH = "GetServiceDetailsResult"

    # :nodoc:
    RESULT_TYPE = Ldbws::ResponseTypes::ServiceDetails

    # :nodoc:
    def to_soap_params
      {
        serviceID: @params[:service_id].upcase,
      }
    end
  end
end

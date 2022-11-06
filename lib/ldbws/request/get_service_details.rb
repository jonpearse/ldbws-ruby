require "ldbws/request/base"

require "ldbws/response_types/service_details"

module Ldbws::Request
  class GetServiceDetails < Base
    SCHEMA = Dry::Schema.Params do
      required(:service_id).filled(:string)
    end

    RESULT_XPATH = "GetServiceDetailsResult"

    RESULT_TYPE = Ldbws::ResponseTypes::ServiceDetails

    def to_soap_params
      {
        serviceID: @params[:service_id],
      }
    end
  end
end

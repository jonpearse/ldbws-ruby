require "spec_helper"
require "helpers/request_helper"

describe Ldbws::Request::GetServiceDetails do
  include RequestHelper

  let (:subject) { Ldbws::Request::GetServiceDetails }

  context :to_soap do
    it "upcases the service ID" do
      soap = to_soap_str(service_id: "1234567crdfcen_")

      expect(soap).to include("<serviceID>1234567CRDFCEN_</serviceID>")
    end
  end
end

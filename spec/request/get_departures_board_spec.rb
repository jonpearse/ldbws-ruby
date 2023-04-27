require "spec_helper"
require "helpers/request_helper"

describe Ldbws::Request::GetDeparturesBoard do
  include RequestHelper

  let(:subject) { Ldbws::Request::GetDeparturesBoard }

  context :validation do
    context :crs do
      it "requires a CRS" do
        expect_error({}, :crs, "is missing")
      end

      it "enforces the length requirement" do
        expect_error({ crs: "x" }, :crs, "length must be 3")
        expect_error({ crs: "xxxx" }, :crs, "length must be 3")
      end
    end

    context :filter_list do
      it "requires at least one to be specified" do
        expect_error({}, :filter_list, "is missing")

        expect_error({ filter_list: [] }, :filter_list, "cannot be less than 1")
      end

      it "enforces the length requirement" do
        expect_error({ filter_list: ["x"] }, :filter_list, "length must be 3")
        expect_error({ filter_list: ["xxxx"] }, :filter_list, "length must be 3")
      end

      it "works with something that looks like a CRS (inexhaustive validation)" do
        expect_ok(crs: "xxx", filter_list: %w{ abc def })
      end
    end
  end

  context :to_soap do
    it "upcases the CRS field" do
      soap = to_soap_str(crs: "cdf", filter_list: %w{ pad pmh swa })

      expect(soap).to include("<crs>CDF</crs>")
    end

    it "correctly encodes the filterList field" do
      soap = to_soap_str(crs: "cdf", filter_list: %w{ pad pmh swa })

      # strip newlines and indents to make matching easier
      soap.gsub!(/\n\s*/, "")

      expect(soap).to include("<filterList><crs>PAD</crs><crs>PMH</crs><crs>SWA</crs></filterList>")
    end
  end
end

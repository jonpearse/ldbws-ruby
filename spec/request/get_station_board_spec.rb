require "spec_helper"
require "helpers/request_helper"

describe Ldbws::Request::GetStationBoard do
  include RequestHelper

  let (:subject) { Ldbws::Request::GetStationBoard }

  context :validation do
    context :crs do
      it "requires the parameter" do
        expect_error({}, :crs, "is missing")
      end

      it "enforces the length requirement" do
        expect_error({ crs: "x" }, :crs, "length must be 3")
        expect_error({ crs: "xxxx" }, :crs, "length must be 3")
      end

      it "works with something that looks like a CRS (inexhaustive validation)" do
        expect_ok(crs: "xxx")
      end
    end

    context :filter_crs do
      it "enforces the length requirement" do
        expect_error({ filter_crs: "x" }, :filter_crs, "length must be 3")
        expect_error({ filter_crs: "xxxx" }, :filter_crs, "length must be 3")
      end

      it "works with something that looks like a CRS (inexhaustive validation)" do
        expect_ok(crs: "xxx", filter_crs: "abc")
      end
    end

    context :filter_type do
      it "doesn’t allow arbitrary values" do
        expect_error({ filter_type: "wibble" }, :filter_type, "must be one of: to, from")
      end

      it "allows real values" do
        expect_ok(crs: "xxx", filter_type: "to")
      end

      it "is case-insensitive" do
        expect_ok(crs: "xxx", filter_type: "from")
        expect_ok(crs: "xxx", filter_type: "FROM")
        expect_ok(crs: "xxx", filter_type: "fRoM")
      end
    end
  end

  context :to_soap do
    it "upcases all CRSen" do
      soap = to_soap_str(crs: "cdf", filter_crs: "swa")

      expect(soap).to include("<crs>CDF</crs>")
      expect(soap).to include("<filterCrs>SWA</filterCrs>")
    end

    it "downcases the filter_type" do
      soap = to_soap_str(crs: "cdf", filter_crs: "swa", filter_type: "FROM")

      expect(soap).to include("<filterType>from</filterType>")
    end

    it "removes filter_type if filter_crs is not set" do
      soap = to_soap_str(crs: "cdf", filter_type: "from")

      expect(soap).not_to include("<filterType>from</filterType>")
    end
  end
end

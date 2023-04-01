require "nokogiri"

require "ldbws/http_request"
require "ldbws/request/get_departures_board"
require "ldbws/request/get_service_details"
require "ldbws/request/get_station_board"
require "ldbws/utils"

module Ldbws
  class Service
    class << self
      private def add_request(name, soap_action, request_type)
        define_method(name) do |args|
          do_request(
            Utils.to_snake_case(name.to_s, true),
            soap_action,
            request_type.new(args)
          )
        end
      end
    end

    SERVICE_URI = URI("https://realtime.nationalrail.co.uk/OpenLDBWS/ldb12.asmx")

    def initialize(token, request_klass = Ldbws::HttpRequest)
      @token = token
      @url = URI("https://realtime.nationalrail.co.uk/OpenLDBWS/ldb12.asmx")
      @requester = request_klass
    end

    # Basic arrival + departure
    add_request :get_departure_board,
                "http://thalesgroup.com/RTTI/2012-01-13/ldb/GetDepartureBoard",
                Request::GetStationBoard

    add_request :get_arrival_board,
                "http://thalesgroup.com/RTTI/2012-01-13/ldb/GetArrivalBoard",
                Request::GetStationBoard

    add_request :get_arrival_departure_board,
                "http://thalesgroup.com/RTTI/2012-01-13/ldb/GetArrivalDepartureBoard",
                Request::GetStationBoard

    # Arrival + departure with details
    add_request :get_dep_board_with_details,
                "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetDepBoardWithDetails",
                Request::GetStationBoardWithDetails

    add_request :get_arr_board_with_details,
                "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetArrBoardWithDetails",
                Request::GetStationBoardWithDetails

    add_request :get_arr_dep_board_with_details,
                "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetArrDepBoardWithDetails",
                Request::GetStationBoardWithDetails

    # Next + fastest departures
    add_request :get_next_departures,
                "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetNextDepartures",
                Request::GetDeparturesBoard

    add_request :get_fastest_departures,
                "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetFastestDepartures",
                Request::GetDeparturesBoard

    # Next + fastest departures with details
    add_request :get_next_departures_with_details,
                "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetNextDeparturesWithDetails",
                Request::GetDeparturesBoardWithDetails

    add_request :get_fastest_departures_with_details,
                "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetFastestDeparturesWithDetails",
                Request::GetDeparturesBoardWithDetails

    add_request :get_service_details,
                "http://thalesgroup.com/RTTI/2012-01-13/ldb/GetServiceDetails",
                Request::GetServiceDetails

    alias_method :get_departure_board_with_details, :get_dep_board_with_details
    alias_method :get_arrival_board_with_details, :get_arr_board_with_details
    alias_method :get_arrival_departure_board_with_details, :get_arr_dep_board_with_details

    private

    def do_request(root_node, soap_action, request)
      # generate our SOAP request + send it
      soap_in = create_soap_request(request, root_node)

      # Fire it off
      soap_response = @requester.send(SERVICE_URI, soap_action, soap_in)

      # Parse
      xml = Nokogiri::XML(soap_response)
      xml.remove_namespaces!

      response_node = xml.xpath("//#{root_node}Response").first
      raise "Oh no" unless response_node

      request.from_soap(response_node)
    end

    def create_soap_request(request, root_node)
      Nokogiri::XML::Builder.new do |xml|
        xml.Envelope(xmlns: "http://schemas.xmlsoap.org/soap/envelope/") {
          xml.Header {
            xml.AccessToken(xmlns: "http://thalesgroup.com/RTTI/2013-11-28/Token/types") {
              xml.TokenValue @token
            }
          }
          xml.Body {
            xml.send("#{root_node}Request", xmlns: "http://thalesgroup.com/RTTI/2021-11-01/ldb/") {
              request.to_soap(xml)
            }
          }
        }
      end.to_xml
    end
  end
end

require "nokogiri"

require "ldbws/http_request"
require "ldbws/request/get_departures_board"
require "ldbws/request/get_service_details"
require "ldbws/request/get_station_board"
require "ldbws/utils"

module Ldbws
  # A wrapper around the National Rail Live Departure Boards Webservice (LDBWS) API.
  #
  # API methods are pretty much as-specified in {the documentation}[https://lite.realtime.nationalrail.co.uk/openldbws/],
  # although methods on this class are specified using snake_case rather than the CamelCase used in the web service.
  #
  # === Usage example
  #
  # TL;DR:
  #
  #  service = new Ldbws::Service( "YOUR-API-TOKEN" )
  #  departures = service.get_departure_board( crs: "CDF" )
  #
  # Will furnish you with a list of all departures from Cardiff Central. Other methods work pretty much as you’d expect
  # if you’ve any familiarity with the service.
  # Individual requests use Request[rdoc-ref:Request] objects to validate input parameters, and this is noted below. See
  # the corresponding request object for each method for further information as to the parameters.
  #
  # === Caching requests
  #
  # <i>⚠️ Warning: this is subject to change: the current behaviour is just a bit horrible! ⚠️</i>
  #
  # LDBWS implements restrictions on the number of requests that are made in a given time period. The casual user is
  # (probably) unlikely to hit them, but if you’re building any kind of automated service or initially beginning to
  # play around with the system, you might want to cache responses to avoid tempting fate.
  #
  # To facilitiate this, the constructor for this class takes an optional second parameter allowing a developer to
  # override the internal code that makes the HTTP request (yes, this is gronky: I’m open to suggestions). Any class/instance
  # passed into this argument must specify a +#send+ method that takes three parameters and makes a POST request, returning
  # the content of the response body.
  #
  # The parameters are:
  #
  # url:: the URL to make the request to, as a string.
  # soap_action:: the value of the +SOAPAction+ header that will be sent with the request.
  # body:: the body of the request, as a string.
  #
  # How exactly this works internally is left as an exercise to the implementor :)
  #
  # === Side note
  #
  # The official documentation for this web service is… lacking. While an attempt has been made to elucidate on both the
  # request parameters and response properties, it shouldn’t be taken as any kind of source of truth. Caveat emptor.
  class Service
    SERVICE_URI = URI("https://realtime.nationalrail.co.uk/OpenLDBWS/ldb12.asmx") # :nodoc:

    # Creates a service object.
    #
    # === Parameters
    # token:: the API token used to connect to the service
    # request_klass:: a module or instance of a class used to make the request to the service (optional)
    def initialize(token, request_klass = Ldbws::HttpRequest)
      @token = token
      @requester = request_klass
    end

    # Retrieves a station departure board.
    #
    # Parameters are validated using GetStationBoard[rdoc-ref:Request::GetStationBoard], returns a
    # StationBoard[rdoc-ref:ResponseTypes::StationBoard] object.
    def get_departure_board(params)
      do_request(
        "http://thalesgroup.com/RTTI/2012-01-13/ldb/GetDepartureBoard",
        Request::GetStationBoard.new(params)
      )
    end

    # Retrieves a station arrival board.
    #
    # Parameters are validated using GetStationBoard[rdoc-ref:Request::GetStationBoard], returns a
    # StationBoard[rdoc-ref:ResponseTypes::StationBoard] object.
    def get_arrival_board(params)
      do_request(
        "http://thalesgroup.com/RTTI/2012-01-13/ldb/GetArrivalBoard",
        Request::GetStationBoard.new(params)
      )
    end

    # Retrieves a station arrival + departure board.
    #
    # Parameters are validated using GetStationBoard[rdoc-ref:Request::GetStationBoard], returns a
    # StationBoard[rdoc-ref:ResponseTypes::StationBoard] object.
    def get_arrival_departure_board(params)
      do_request(
        "http://thalesgroup.com/RTTI/2012-01-13/ldb/GetArrivalDepartureBoard",
        Request::GetStationBoard.new(params)
      )
    end

    # Retrieves a detailed station departure board.
    #
    # Parameters are validated using GetStationBoardWithDetails[rdoc-ref:Request:GetStationBoardWithDetails], returns a
    # StationBoardWithDetails[rdoc-ref:ResponseTypes::StationBoardWithDetails] object.
    def get_dep_board_with_details(params)
      do_request(
        "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetDepBoardWithDetails",
        Request::GetStationBoardWithDetails.new(params)
      )
    end

    # Retrieves a detailed station arrival board.
    #
    # Parameters are validated using GetStationBoardWithDetails[rdoc-ref:Request:GetStationBoardWithDetails], returns a
    # StationBoardWithDetails[rdoc-ref:ResponseTypes::StationBoardWithDetails] object.
    def get_arr_board_with_details(params)
      do_request(
        "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetArrBoardWithDetails",
        Request::GetStationBoardWithDetails.new(params)
      )
    end

    # Retrieves a detailed station arrival + departures board.
    #
    # Parameters are validated using GetStationBoardWithDetails[rdoc-ref:Request:GetStationBoardWithDetails], returns a
    # StationBoardWithDetails[rdoc-ref:ResponseTypes::StationBoardWithDetails] object.
    def get_arr_dep_board_with_details(params)
      do_request(
        "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetArrDepBoardWithDetails",
        Request::GetStationBoardWithDetails.new(params)
      )
    end

    # Retrieves the next departures from one station to one or many others.
    #
    # Parameters are validated using GetDeparturesBoard[rdoc-ref:Request::GetDeparturesBoard], returns a
    # DeparturesBoard[rdoc-ref:ResponseTypes::DeparturesBoard] object.
    def get_next_departures(params)
      do_request(
        "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetNextDepartures",
        Request::GetDeparturesBoard.new(params)
      )
    end

    # Retrieves the fastest departures from one station to one or many others.
    #
    # Parameters are validated using GetDeparturesBoard[rdoc-ref:Request::GetDeparturesBoard], returns a
    # DeparturesBoard[rdoc-ref:ResponseTypes::DeparturesBoard] object.
    def get_next_departures(params)
      do_request(
        "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetFastestDepartures",
        Request::GetDeparturesBoard.new(params)
      )
    end

    # Retrieves detailed information about the next departures from one station to one or many others.
    #
    # Parameters are validated using GetDeparturesBoardWithDetails[rdoc-ref:Request::GetDeparturesBoardWithDetails],
    # returns a DeparturesBoardWithDetails[rdoc-ref:ResponseTypes::DeparturesBoardWithDetails] object.
    def get_next_departures_with_details(params)
      do_request(
        "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetNextDeparturesWithDetails",
        Request::GetDeparturesBoardWithDetails.new(params)
      )
    end

    # Retrieves detailed information about the fastest departures from one station to one or many others.
    #
    # Parameters are validated using GetDeparturesBoardWithDetails[rdoc-ref:Request::GetDeparturesBoardWithDetails],
    # returns a DeparturesBoardWithDetails[rdoc-ref:ResponseTypes::DeparturesBoardWithDetails] object.
    def get_fastest_departures_with_details(params)
      do_request(
        "http://thalesgroup.com/RTTI/2015-05-14/ldb/GetFastestDeparturesWithDetails",
        Request::GetDeparturesBoardWithDetails.new(params)
      )
    end

    # Retrieves information about a specific service.
    #
    # Parameters are validated using GetServiceDetails[rdoc-ref:Request::GetServiceDetails], returns a
    # ServiceDetails[rdoc-ref:ResponseTypes::ServiceDetails] object.
    def get_service_details(params)
      do_request(
        "http://thalesgroup.com/RTTI/2012-01-13/ldb/GetServiceDetails",
        Request::GetServiceDetails.new(params)
      )
    end

    alias_method :get_departure_board_with_details, :get_dep_board_with_details
    alias_method :get_arrival_board_with_details, :get_arr_board_with_details
    alias_method :get_arrival_departure_board_with_details, :get_arr_dep_board_with_details

    private

    def do_request(soap_action, request)
      root_node = soap_action.split("/").last
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

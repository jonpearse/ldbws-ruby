var search_data = {"index":{"searchIndex":["ldbws","request","getdeparturesboard","getdeparturesboardwithdetails","getservicedetails","getstationboard","getstationboardwithdetails","paramvalidationerror","responsetypes","basestationboard","callingpoint","coach","departureitem","departureitemwithdetails","departuresboard","departuresboardwithdetails","formation","loadingcategory","location","servicedetails","serviceitem","serviceitemwithcallingpoints","stationboard","stationboardwithdetails","toiletavailability","service","get_arr_board_with_details()","get_arr_dep_board_with_details()","get_arrival_board()","get_arrival_board_with_details()","get_arrival_departure_board()","get_arrival_departure_board_with_details()","get_dep_board_with_details()","get_departure_board()","get_departure_board_with_details()","get_fastest_departures_with_details()","get_next_departures()","get_next_departures_with_details()","get_service_details()","messages()","new()","service()","license","readme"],"longSearchIndex":["ldbws","ldbws::request","ldbws::request::getdeparturesboard","ldbws::request::getdeparturesboardwithdetails","ldbws::request::getservicedetails","ldbws::request::getstationboard","ldbws::request::getstationboardwithdetails","ldbws::request::paramvalidationerror","ldbws::responsetypes","ldbws::responsetypes::basestationboard","ldbws::responsetypes::callingpoint","ldbws::responsetypes::coach","ldbws::responsetypes::departureitem","ldbws::responsetypes::departureitemwithdetails","ldbws::responsetypes::departuresboard","ldbws::responsetypes::departuresboardwithdetails","ldbws::responsetypes::formation","ldbws::responsetypes::loadingcategory","ldbws::responsetypes::location","ldbws::responsetypes::servicedetails","ldbws::responsetypes::serviceitem","ldbws::responsetypes::serviceitemwithcallingpoints","ldbws::responsetypes::stationboard","ldbws::responsetypes::stationboardwithdetails","ldbws::responsetypes::toiletavailability","ldbws::service","ldbws::service#get_arr_board_with_details()","ldbws::service#get_arr_dep_board_with_details()","ldbws::service#get_arrival_board()","ldbws::service#get_arrival_board_with_details()","ldbws::service#get_arrival_departure_board()","ldbws::service#get_arrival_departure_board_with_details()","ldbws::service#get_dep_board_with_details()","ldbws::service#get_departure_board()","ldbws::service#get_departure_board_with_details()","ldbws::service#get_fastest_departures_with_details()","ldbws::service#get_next_departures()","ldbws::service#get_next_departures_with_details()","ldbws::service#get_service_details()","ldbws::request::paramvalidationerror#messages()","ldbws::service::new()","ldbws::service()","",""],"info":[["Ldbws","","Ldbws.html","","<p>Provides a Ruby abstraction around the UK’s Network Rail live departure board webservice (LDBWS). See …\n"],["Ldbws::Request","","Ldbws/Request.html","",""],["Ldbws::Request::GetDeparturesBoard","","Ldbws/Request/GetDeparturesBoard.html","","<p>Requests a departure board for a station, filtered by departures to one or many other stations. Corresponds …\n"],["Ldbws::Request::GetDeparturesBoardWithDetails","","Ldbws/Request/GetDeparturesBoardWithDetails.html","","<p>Requests a departure board for a statuion, filtered by departures to one or more other stations. This …\n"],["Ldbws::Request::GetServiceDetails","","Ldbws/Request/GetServiceDetails.html","","<p>Returns details about a particular service. Corresponds to <code>GetServiceDetailsResponse</code> in the LDBWS schema. …\n"],["Ldbws::Request::GetStationBoard","","Ldbws/Request/GetStationBoard.html","","<p>Returns an arrival or departure board for a given station. Corresponds to <code>GetStationBoardRequest</code> in the …\n"],["Ldbws::Request::GetStationBoardWithDetails","","Ldbws/Request/GetStationBoardWithDetails.html","","<p>Returns an arrival or departure board for a given station with full service details. Corresponds to  …\n"],["Ldbws::Request::ParamValidationError","","Ldbws/Request/ParamValidationError.html","","<p>Raised when an error occurs when validating request parameters. Messages are passed through directly …\n"],["Ldbws::ResponseTypes","","Ldbws/ResponseTypes.html","",""],["Ldbws::ResponseTypes::BaseStationBoard","","Ldbws/ResponseTypes/BaseStationBoard.html","","<p>Base station board information. This does not directly correspond to a type in LDBWS.\n<p>Properties\n"],["Ldbws::ResponseTypes::CallingPoint","","Ldbws/ResponseTypes/CallingPoint.html","","<p>Represents a calling point in the LDBWS.\n<p>Properties\n<p>location_name &mdash; the name of the station\n"],["Ldbws::ResponseTypes::Coach","","Ldbws/ResponseTypes/Coach.html","","<p>Information about an individual coach in the train.\n<p>Properties\n<p>number &mdash; the coach number or identifier\n"],["Ldbws::ResponseTypes::DepartureItem","","Ldbws/ResponseTypes/DepartureItem.html","","<p>Represents an item on a departure board.\n<p>Properties\n<p>crs &mdash; the CRS for the item\n"],["Ldbws::ResponseTypes::DepartureItemWithDetails","","Ldbws/ResponseTypes/DepartureItemWithDetails.html","","<p>Represents an item on a departure board with additional details.\n<p>Properties\n<p>crs &mdash; the CRS for the item\n"],["Ldbws::ResponseTypes::DeparturesBoard","","Ldbws/ResponseTypes/DeparturesBoard.html","","<p>Represents a departures board.\n<p>Properties\n<p>departures &mdash; a list of departures.\n"],["Ldbws::ResponseTypes::DeparturesBoardWithDetails","","Ldbws/ResponseTypes/DeparturesBoardWithDetails.html","","<p>Represents a departures board with additional details.\n<p>Properties\n<p>departures &mdash; a list of departures.\n"],["Ldbws::ResponseTypes::Formation","","Ldbws/ResponseTypes/Formation.html","","<p>Information about the formation of a train\n<p>Properties\n<p>loading_category &mdash; how heavily-loaded the train is. …\n"],["Ldbws::ResponseTypes::LoadingCategory","","Ldbws/ResponseTypes/LoadingCategory.html","","<p>The loading category of a train\n<p>Properties\n<p>code, colour, image &mdash; \n"],["Ldbws::ResponseTypes::Location","","Ldbws/ResponseTypes/Location.html","","<p>Represents a location in LDBWS.\n<p>Properties\n<p>name, crs, via &mdash; \n"],["Ldbws::ResponseTypes::ServiceDetails","","Ldbws/ResponseTypes/ServiceDetails.html","","<p>Represents details about a service in LDBWS.\n<p>Properties\n"],["Ldbws::ResponseTypes::ServiceItem","","Ldbws/ResponseTypes/ServiceItem.html","","<p>Represents a service item in LDBWS.\n<p>Properties\n<p>sta &mdash; the scheduled arrival time as a Time object\n"],["Ldbws::ResponseTypes::ServiceItemWithCallingPoints","","Ldbws/ResponseTypes/ServiceItemWithCallingPoints.html","","<p>Represents a service item with additional details in LDBWS: extends ServiceItem.\n<p>Properties\n<p>As ServiceItem …\n"],["Ldbws::ResponseTypes::StationBoard","","Ldbws/ResponseTypes/StationBoard.html","","<p>Represents a station arrival/departure board in LDBWS.\n<p>Properties\n<p>As BaseStationBoard, and additionally: …\n"],["Ldbws::ResponseTypes::StationBoardWithDetails","","Ldbws/ResponseTypes/StationBoardWithDetails.html","","<p>Represents a station arrival/departure board with additional details in LDBWS.\n<p>Properties\n<p>As BaseStationBoard …\n"],["Ldbws::ResponseTypes::ToiletAvailability","","Ldbws/ResponseTypes/ToiletAvailability.html","","<p>The availability of an individual toilet on a train\n<p>Properties\n<p>type &mdash; the type of toilet\n"],["Ldbws::Service","","Ldbws/Service.html","","<p>A wrapper around the National Rail Live Departure Boards Webservice (LDBWS) API.\n<p>API methods are pretty …\n"],["get_arr_board_with_details","Ldbws::Service","Ldbws/Service.html#method-i-get_arr_board_with_details","(params)","<p>Retrieves a detailed station arrival board.\n<p>Parameters are validated using GetStationBoardWithDetails …\n"],["get_arr_dep_board_with_details","Ldbws::Service","Ldbws/Service.html#method-i-get_arr_dep_board_with_details","(params)","<p>Retrieves a detailed station arrival + departures board.\n<p>Parameters are validated using GetStationBoardWithDetails …\n"],["get_arrival_board","Ldbws::Service","Ldbws/Service.html#method-i-get_arrival_board","(params)","<p>Retrieves a station arrival board.\n<p>Parameters are validated using GetStationBoard, returns a StationBoard …\n"],["get_arrival_board_with_details","Ldbws::Service","Ldbws/Service.html#method-i-get_arrival_board_with_details","(params)",""],["get_arrival_departure_board","Ldbws::Service","Ldbws/Service.html#method-i-get_arrival_departure_board","(params)","<p>Retrieves a station arrival + departure board.\n<p>Parameters are validated using GetStationBoard, returns …\n"],["get_arrival_departure_board_with_details","Ldbws::Service","Ldbws/Service.html#method-i-get_arrival_departure_board_with_details","(params)",""],["get_dep_board_with_details","Ldbws::Service","Ldbws/Service.html#method-i-get_dep_board_with_details","(params)","<p>Retrieves a detailed station departure board.\n<p>Parameters are validated using GetStationBoardWithDetails …\n"],["get_departure_board","Ldbws::Service","Ldbws/Service.html#method-i-get_departure_board","(params)","<p>Retrieves a station departure board.\n<p>Parameters are validated using GetStationBoard, returns a StationBoard …\n"],["get_departure_board_with_details","Ldbws::Service","Ldbws/Service.html#method-i-get_departure_board_with_details","(params)",""],["get_fastest_departures_with_details","Ldbws::Service","Ldbws/Service.html#method-i-get_fastest_departures_with_details","(params)","<p>Retrieves detailed information about the fastest departures from one station to one or many others.\n<p>Parameters …\n"],["get_next_departures","Ldbws::Service","Ldbws/Service.html#method-i-get_next_departures","(params)","<p>Retrieves the next departures from one station to one or many others.\n<p>Parameters are validated using  …\n"],["get_next_departures_with_details","Ldbws::Service","Ldbws/Service.html#method-i-get_next_departures_with_details","(params)","<p>Retrieves detailed information about the next departures from one station to one or many others.\n<p>Parameters …\n"],["get_service_details","Ldbws::Service","Ldbws/Service.html#method-i-get_service_details","(params)","<p>Retrieves information about a specific service.\n<p>Parameters are validated using GetServiceDetails, returns …\n"],["messages","Ldbws::Request::ParamValidationError","Ldbws/Request/ParamValidationError.html#method-i-messages","()","<p>Returns the validation error messages as a hash.\n"],["new","Ldbws::Service","Ldbws/Service.html#method-c-new","(token)","<p>Creates a service object.\n<p>Parameters\n<p>token &mdash; the API token used to connect to the service\n"],["service","Ldbws","Ldbws.html#method-c-service","(token)","<p>Helper method that returns an instance of [Service].\n<p>Parameters\n<p>token &mdash; the API token used to connect to …\n"],["LICENSE","","LICENSE.html","","<p>MIT License\n<p>Copyright © 2022 Jon Pearse\n<p>Permission is hereby granted, free of charge, to any person obtaining …\n"],["README","","README_md.html","","<p>ldbws-ruby\n<p>I’ll write a proper readme/howto at some point, but short version is that this is a Ruby wrapper …\n"]]}}
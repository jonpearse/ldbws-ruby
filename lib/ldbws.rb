require "ldbws/service"

# Provides a Ruby abstraction around the UK’s Network Rail live departure board webservice (LDBWS). See
# Service[rdoc-ref:Ldbws::Service] for more information.
module Ldbws
  # Helper method that returns an instance of [rdoc-ref:Service].
  #
  # === Parameters
  # token:: the API token used to connect to the service
  def self.service(token)
    Service.new(token)
  end

  # Raised when a request has resulted in an error that this library can make some sense of. This <i>usually</i>
  # occurs due to something being wrong with a request like an invalid CRS code.
  #
  # Unfortunately LDBWS doesn’t generate particularly helpful CRS codes, so the #details method will return a hashified
  # version of the response from the server.
  #
  # Thus, for a missing CRS, you’ll get:
  #
  # 	{
  #   	faultcode: "soap:Server",
  #   	faultstring: "Unexpected server error",
  #   	detail: ""
  # 	}
  #
  # Which isn’t especially useful. Best suggestion if you get this is to double-check your code to make sure the request
  # is sane.
  class RequestError < RuntimeError
    def initialize(details) # :nodoc:
      @details = details
    end

    # Returns the details of the error as a hash.
    def details
      @details
    end
  end

  # Raised when a response from LDBWS cannot be parsed by this library. This is unexpected, and generally means you’ll
  # need to raise an issue against this gem.
  class ResponseParsingError < RuntimeError; end
end

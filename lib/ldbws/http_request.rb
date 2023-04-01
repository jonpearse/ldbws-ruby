require "faraday"
require "uri"

module Ldbws
  class HttpRequest
    def self.send(url, soap_action, body)
      uri = URI(url)

      conn = Faraday.new(
        url: "#{uri.scheme}://#{uri.host}",
        headers: {
          'Content-Type': "text/xml",
          'SOAPAction': soap_action,
        },
      )

      conn.post(uri.path, body).body
    end
  end
end

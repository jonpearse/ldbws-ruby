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
end

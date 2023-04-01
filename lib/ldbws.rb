require "ldbws/service"

module Ldbws
  def self.service(token)
    Service.new(token)
  end
end

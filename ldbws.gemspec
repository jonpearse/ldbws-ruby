lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require "ldbws/version"

Gem::Specification.new do |spec|
  spec.name = "ldbws"
  spec.summary = "Interface to the Network Rail OpenLDBS web service"
  spec.license = "MIT"

  spec.authors = "Jon Pearse"
  spec.email = "hello@jonpearse.net"
  spec.homepage = "https://github.com/jonpearse/ldbws-ruby"

  spec.version = Ldbws::VERSION
  spec.files = `git ls-files`.split($\)

  spec.add_dependency "dry-schema", "~> 1.10"
  spec.add_dependency "faraday", "~> 2.6"
  spec.add_dependency "nokogiri", "~> 1.13"

  spec.add_development_dependency "rdoc", "~> 6.5.0"
  spec.add_development_dependency "rspec", "~> 3.11"
  spec.add_development_dependency "rufo", "~> 0.13.0"
end

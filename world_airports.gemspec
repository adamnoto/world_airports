# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'world_airports/version'

Gem::Specification.new do |spec|
  spec.name          = "world_airports"
  spec.version       = WorldAirports::VERSION
  spec.authors       = ["Adam Pahlevi"]
  spec.email         = ["adam.pahlevi@gmail.com"]
  spec.summary       = %q{Get airport details based on IATA code}
  spec.description   = %q{This gem will translate an IATA into an airport name, location, city and country information. Wikipedia has provided the list of the airports}
  spec.homepage      = "http://adampahlevi.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.cert_chain    = ['certs/adampahlevi.pem']
  spec.signing_key      = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end

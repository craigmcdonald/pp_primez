# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pp_primez/version'

Gem::Specification.new do |spec|
  spec.name          = "pp_primez"
  spec.version       = PpPrimez::VERSION
  spec.authors       = ["Craig McDonald"]
  spec.email         = ["lefthandcraig@gmail.com"]
  spec.summary       = %q{Prints the multiplication tables for n primes.}
  spec.description   = %q{Prints the multiplication tables for n primes.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ["pp_primez"]
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("terminal-table", "~>1.4.5")
  spec.add_dependency("highline","~> 1.7.1")
  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry", "~> 0.10.1"
end

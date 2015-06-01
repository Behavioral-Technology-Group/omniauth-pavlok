# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-pavlok/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-pavlok"
  spec.version       = OmniAuth::Pavlok::VERSION
  spec.authors       = ["Pavlok"]
  spec.email         = ["team@pavlok.com"]
  spec.summary       = %q{Pavlok OmniAuth strategy}
  spec.description   = %q{Pavlok OmniAuth strategy to make Ruby/Rails OmniAuth clients easier to implement.}
  spec.homepage      = "http://pavlok.com"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'omniauth', '~> 1.0'
  spec.add_dependency 'omniauth-oauth2', '>= 1.1.1', '< 2.0'

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 2.99'
  spec.add_development_dependency 'rack-test', '~> 0.6'
  spec.add_development_dependency 'simplecov', '~> 0.10'
  spec.add_development_dependency 'webmock', '~> 1.21'
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cardspring_browse/version'

Gem::Specification.new do |spec|
  spec.name          = "cardspring_browse"
  spec.version       = CardspringBrowse::VERSION
  spec.authors       = ["Jason Clark"]
  spec.email         = ["jason@jjasonclark.com"]
  spec.description   = %q{Browse Cardspring data via the CardSpring API}
  spec.summary       = %q{Browse Cardspring data via the CardSpring API}
  spec.homepage      = "https://github.com/jjasonclark/cardspring_browse"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "thin"
  spec.add_runtime_dependency "sinatra", "~> 1.4.3"
  spec.add_runtime_dependency "faraday", "~> 0.8.8"
end

# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'octopress/version'

Gem::Specification.new do |spec|
  spec.name          = "octopress"
  spec.version       = Octopress::VERSION
  spec.authors       = ["Christopher Keele"]
  spec.email         = ["dev@chriskeele.com"]
  spec.description   = "Octopress, gemmified."
  spec.summary       = "Octopress, gemmified."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'sinatra', '~> 1.4.2'

  spec.add_runtime_dependency 'thor', '~> 0.18.1'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake", '~> 0.9'
end

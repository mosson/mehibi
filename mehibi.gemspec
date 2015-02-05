# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mehibi/version'

Gem::Specification.new do |spec|
  spec.name          = 'mehibi'
  spec.version       = Mehibi::VERSION
  spec.authors       = ['mosson']
  spec.email         = ['cucation@gmail.com']
  spec.summary       = 'To make word of clusters for searching'
  spec.description   = 'To make word of clusters for searching'
  spec.homepage      = 'https://github.com/mosson/mehibi'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec'
end

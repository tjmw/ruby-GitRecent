# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'git_recent/version'

Gem::Specification.new do |spec|
  spec.name          = 'git_recent'
  spec.version       = GitRecent::VERSION
  spec.authors       = ['Tom Wey']
  spec.email         = ['tjmwey@gmail.com']
  spec.description   = %q{Gem for displaying and interacting with recently checked-out git branches}
  spec.summary       = %q{Gem for displaying and interacting with recently checked-out git branches}
  spec.homepage      = 'https://github.com/tjmw/ruby-GitRecent'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'

  spec.add_dependency 'thor', '~> 0.18.1'
end

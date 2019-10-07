# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'eslint-rails-ee/version'

Gem::Specification.new do |spec|
  spec.name          = 'eslint-rails-ee'
  spec.version       = ESLintRails::VERSION
  spec.authors       = ['David Valentine', 'Justin Force', 'Jon Kessler']
  spec.email         = ['davidlewisrogers3@gmail.com', 'justin.force@appfolio.com', 'jon.kessler@appfolio.com']
  spec.summary       = %q{A Rails wrapper for ESLint}
  spec.description   = spec.summary
  spec.homepage      = 'https://github.com/dlvalentine/eslint-rails-ee'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.0.0'

  spec.add_dependency 'railties', '>= 3.2'
  spec.add_dependency 'execjs'
  spec.add_dependency 'therubyracer'
  spec.add_dependency 'colorize'

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
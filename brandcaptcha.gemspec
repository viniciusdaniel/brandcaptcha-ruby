# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'brandcaptcha/version'

Gem::Specification.new do |spec|
  spec.name          = 'brandcaptcha'
  spec.version       = Brandcaptcha::VERSION
  spec.authors       = ['Vinicius Daniel Antunes Oliveira']
  spec.email         = ['viniciusdaniel@gmail.com']

  spec.summary       = 'BrandCAPTCHA API integration for Ruby'
  spec.description   = 'The BrandCAPTCHA Ruby Library provides a simple way to place a BrandCAPTCHA on your PHP website, helping you stop bots from abusing it. The library wraps the BrandCAPTCHA API.'
  spec.homepage      = 'https://github.com/viniciusdaniel/brandcaptcha-ruby'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.9'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.3'
end

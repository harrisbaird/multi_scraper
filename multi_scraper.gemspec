# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'multi_scraper/version'
Gem::Specification.new do |spec|
  spec.name          = 'multi_scraper'
  spec.version       = MultiScraper::VERSION
  spec.authors       = ['harrisbaird']
  spec.email         = ['mydancake@gmail.com']
  spec.description   = 'A web scraper which simplifies scraping both feeds and web pages.'
  spec.summary       = 'A simple web scraper with feed support.'
  spec.homepage      = 'http://github.com/harrisbaird/multi_scraper'
  spec.license       = 'MIT'
  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']
  spec.add_dependency 'feedjira', '~> 1.4'
  spec.add_dependency 'nokogiri', '~> 1.6'
  spec.add_development_dependency 'rspec', '~> 3.1'
  spec.add_development_dependency 'rspec-collection_matchers', '~> 1.0'
  spec.add_development_dependency 'vcr'
  spec.add_development_dependency 'webmock'
end

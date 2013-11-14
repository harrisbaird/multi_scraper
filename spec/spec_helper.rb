require 'rspec/collection_matchers'
require 'simplecov'
require 'vcr'
require 'coveralls'
require 'codeclimate-test-reporter'

SimpleCov.start do
  add_filter '/spec'
  coverage_dir 'spec/coverage'
end

require 'multi_scraper'

VCR.configure do |c|
  c.cassette_library_dir = 'spec'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

RSpec.configure do |config|
  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.mock_with :rspec do |c|
    c.syntax = :expect
  end

  config.filter_run :focus
  config.run_all_when_everything_filtered = true
  config.order = :random
  Kernel.srand config.seed

  config.around(:each) do |example|
    options = example.metadata[:vcr] || {}
    VCR.use_cassette('cassette', options, &example)
  end

  config.after(:suite) do
    WebMock.disable_net_connect!(allow: 'codeclimate.com')
  end
end

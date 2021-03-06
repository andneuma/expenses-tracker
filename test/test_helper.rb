ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "minitest/rails"
# require "minitest/reporters"
require "minitest/rails/capybara" # For integration tests

reporter_options = { color: true }
Minitest::Reporters.use!(
  # Minitest::Reporters::DefaultReporter.new(reporter_options),
  Minitest::Reporters::SpecReporter.new,
  ENV,
  Minitest.backtrace_filter)


class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  # Add more helper methods to be used by all tests here...
end

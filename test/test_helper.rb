ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

# The bar chart for tests.
require "minitest/reporters"
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Make FactoryGirl code concise.
  include FactoryGirl::Syntax::Methods

  # Make helpers available in tests.
  include ApplicationHelper
  include MovingsHelper
  include HouseholdItemsHelper

  private

    # Returns true inside an integration test.
    def integration_test?
      defined?(post_via_redirect)
    end
end

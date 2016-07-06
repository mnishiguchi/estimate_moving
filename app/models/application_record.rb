class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # To use utitlity methods to convert between m3 and ft3.
  include MovingsHelper
end

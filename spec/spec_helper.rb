require 'capybara/rspec'
require 'capybara/webkit'
require 'dugway'

Capybara.default_driver = :webkit
Capybara.app = Dugway.application

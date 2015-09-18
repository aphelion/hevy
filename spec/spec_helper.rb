require 'capybara/rspec'
require 'capybara/webkit'
require 'dugway'

Capybara::Webkit.configure do |config|
  config.allow_url('ajax.googleapis.com')
  config.allow_url('maxcdn.bootstrapcdn.com')
end

Capybara.default_driver = :webkit
Capybara.app = Dugway.application

require 'capybara/rspec'
require 'capybara/webkit'
require 'dugway'

Capybara::Webkit.configure do |config|
  config.allow_url('fonts.googleapis.com')
  config.allow_url('images.bigcartel.com')
  # config.block_unknown_urls
end

Capybara.default_driver = :webkit
Capybara.app = Dugway.application

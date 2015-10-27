require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'capybara/poltergeist'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
Dir['./spec/helpers/**/*.rb'].sort.each { |f| require f }

Capybara.save_and_open_page_path = 'spec/failures'
Capybara::Screenshot::RSpec.add_link_to_screenshot_for_failed_examples = false

RSpec.configure do |config|
  config.include CartHelper, type: :feature
end

Capybara.run_server = false
Capybara.app_host = ENV['PRODUCTION_HOST'] || 'http://shop.hevy.la'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app)
end

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

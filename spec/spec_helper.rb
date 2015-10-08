# ----------------------------------------
# General
# ----------------------------------------

require 'capybara/rspec'
require 'capybara-screenshot/rspec'
require 'dugway'

Dir['./spec/support/**/*.rb'].sort.each { |f| require f }
Dir['./spec/helpers/**/*.rb'].sort.each { |f| require f }

Capybara.save_and_open_page_path = 'spec/failures'

# ----------------------------------------
# Simple Server Setup (flakey)
# ----------------------------------------

# Capybara.app = Dugway.application
#
# RSpec.configure do |config|
#   config.before(:suite) do
#     host = Capybara.current_session.server.host
#     port = Capybara.current_session.server.port
#     puts "I wish I could check #{host} and #{port}"
#   end
#
#   config.include CartHelper, type: :feature
# end

# ----------------------------------------
# Complicated Server Setup
# ----------------------------------------

RSpec.configure do |config|
  config.before(:suite) do
    @dugway_server = DugwayServer.new
    @dugway_server.boot
  end

  config.after(:suite) do
    @dugway_server.kill_process
    puts ''
    puts 'Shutdown complete'
  end

  config.include CartHelper, type: :feature
end

Capybara.run_server = false
Capybara.app_host = DugwayServer.domain

# ----------------------------------------
# Selenium Chrome Driver
# ----------------------------------------

# Capybara.register_driver :selenium_chrome do |app|
#   Capybara::Selenium::Driver.new(app, :browser => :chrome)
# end
#
# Capybara.default_driver = :selenium_chrome
# Capybara.javascript_driver = :selenium_chrome

# ----------------------------------------
# Poltergeist Driver
# ----------------------------------------

require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app)
end

Capybara.default_driver = :poltergeist
Capybara.javascript_driver = :poltergeist

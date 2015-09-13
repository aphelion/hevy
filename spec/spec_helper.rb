require 'capybara/rspec'
require 'capybara/poltergeist'
require 'dugway'

phantomjs_path = File.join(File.dirname(__FILE__), '../node_modules/.bin/phantomjs')

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, {phantomjs: phantomjs_path})
end

Capybara.default_driver = :poltergeist
Capybara.app = Dugway.application

require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'selenium-webdriver'

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :selenium
  config.app_host = 'https://google.com'
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.default_max_wait_time = 2

@root="/"

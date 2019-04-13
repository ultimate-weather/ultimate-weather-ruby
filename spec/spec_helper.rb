require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'webdrivers'

Capybara.configure do |config|
  config.run_server = false
  config.default_driver = :chrome
  config.app_host = 'https://google.com'
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :firefox do |app|
  Capybara::Selenium::Driver.new(app, browser: :firefox)
end

Capybara.default_max_wait_time = 2

RSpec.configure do |config|
  config.after(:each) do |example|
		if defined? page
			tags=''
			['smoke', 'happy', 'sad'].each {|tag| tags+= '__' + tag if example.metadata[tag.to_sym]}
      time = Time.new.to_s[0..18].tr(' ','-')
      description = example.description.tr(' ','_') + tags
      save_file = "screenshots/#{time}__#{description}.png"
      page.save_screenshot(save_file)
    end
  end
end

@root="/"

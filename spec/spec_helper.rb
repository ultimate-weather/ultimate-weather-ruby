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
		if ENV["SCREENSHOTS"] == "true"
			if defined? page
        screenshot(example, page)
			end
    end
  end
end

def screenshot(example, page)
  time = Time.new.to_s[0..18].tr(' ','-')
  description  = example.description.tr(' ','_')
  tags=''
  %w(smoke happy sad).each {|tag| tags+= '__' + tag if example.metadata[tag.to_sym]}
  save_file = "screenshots/#{time}__#{description}#{tags}.png"
  page.save_screenshot(save_file)
end

@root="/"

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

if ENV['TEST_IE'] == 'true'

  CONFIG = {}.freeze
  CONFIG['user'] = ENV['BS_U'.freeze]
  CONFIG['key'] = ENV['BS_P'.freeze]

  require 'selenium/webdriver'
  require 'browserstack/local'
  require 'yaml'

  ENV['BS_USERNAME'] = CONFIG['user']
  ENV['BS_AUTHKEY'] = CONFIG['key']
  url = "http://#{ENV['BS_USERNAME']}:#{ENV['BS_AUTHKEY']}@hub-cloud.browserstack.com/wd/hub"
  capabilities = Selenium::WebDriver::Remote::Capabilities.new
  capabilities['project'] = ENV['BS_AUTOMATE_PROJECT'] if ENV['BS_AUTOMATE_PROJECT']
  capabilities['build'] = ENV['BS_AUTOMATE_BUILD'] if ENV['BS_AUTOMATE_BUILD']
  capabilities['os'] = ENV['SELENIUM_OS'] || 'Windows'
  capabilities['os_version'] = ENV['SELENIUM_OS_VERSION'] || '10'
  capabilities['browser'] = ENV['SELENIUM_BROWSER'] || 'IE'
  capabilities['browser_version'] = ENV['SELENIUM_VERSION'] if ENV['SELENIUM_VERSION']
  capabilities['browserstack.local'] = 'true'
  @caps = capabilities
  browser = Selenium::WebDriver.for(:remote, url: url, desired_capabilities: capabilities)
  @browser = browser

  Capybara.register_driver :browserstack do |app|
    # Code to start browserstack local before start of test
    #  @caps = CONFIG['common_caps'].merge(CONFIG['browser_caps'][TASK_ID])
    #  if @caps['browserstack.local'] && @caps['browserstack.local'].to_s == 'true';
    #    @bs_local = BrowserStack::Local.new
    #    bs_local_args = {"key" => "#{CONFIG['key']}"}
    #    @bs_local.start(bs_local_args)
    #  end

    Capybara::Selenium::Driver.new(
      app,
      browser: :remote,
      url: "http://#{CONFIG['user']}:#{CONFIG['key']}@hub-cloud.browserstack.com/wd/hub",
      desired_capabilities: @caps
    )
  end
end

Capybara.default_max_wait_time = 2
Capybara.default_driver = :chrome

RSpec.configure do |config|
  config.after do |example|
    if ENV['UW_SCREENSHOTS'] == 'true'
      screenshot(example, page) if defined? page
    end
  end
end

def screenshot(example, page)
  time = Time.new.to_s[0..18].tr(' ', '-')
  description = example.description.tr(' ', '_')
  tags = ''
  %w[smoke happy sad].each { |tag| tags += '__' + tag if example.metadata[tag.to_sym] }
  save_file = "screenshots/#{time}__#{description}#{tags}.png"
  page.save_screenshot(save_file)
end

@root = '/'

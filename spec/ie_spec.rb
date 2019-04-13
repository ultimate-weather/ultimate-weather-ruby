describe 'IE browser loads correctly', :type => :feature do
	before :each do |scenario|
		require 'selenium/webdriver'

		ENV["BS_USERNAME"]='michaeldurrant3'
		ENV["BS_AUTHKEY"]='xpVH9NPWHJQLZdR1mbgq'

		url = "http://#{ENV['BS_USERNAME']}:#{ENV['BS_AUTHKEY']}@hub-cloud.browserstack.com/wd/hub"

		capabilities = Selenium::WebDriver::Remote::Capabilities.new

		capabilities['project'] = ENV['BS_AUTOMATE_PROJECT'] if ENV['BS_AUTOMATE_PROJECT']
		capabilities['build'] = ENV['BS_AUTOMATE_BUILD'] if ENV['BS_AUTOMATE_BUILD']

		capabilities['platform'] = ENV['SELENIUM_PLATFORM'] || 'windows'
		capabilities['browser'] = ENV['SELENIUM_BROWSER'] || 'IE'
		capabilities['browser_version'] = ENV['SELENIUM_VERSION'] if ENV['SELENIUM_VERSION']

		browser = Selenium::WebDriver.for(:remote, :url => url, :desired_capabilities => capabilities)

		@browser = browser

    Capybara.current_driver = 'IE'
	end

  after :each do
    @browser.quit
  end

  it 'IE browser has the expected search input field' do
    visit( @root )
    search_button_on_page=find(:css, "input[aria-label='Search']")
    expect(search_button_on_page).to be
  end
  it 'IE browser shows results' do
    visit( @root )
    find(:css, "input[aria-label='Search']").set("123")
    find(:css, "input[aria-label='Search']").send_keys :enter
    expect(page).to have_content 'results'
  end
end

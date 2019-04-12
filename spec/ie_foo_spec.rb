require 'yaml'
require 'rspec'
require 'selenium-webdriver'
require 'browserstack/local'

TASK_ID = (ENV['TASK_ID'] || 0).to_i
CONFIG_NAME = ENV['CONFIG_NAME'] || 'single'

CONFIG = YAML.load(File.read(File.join(File.dirname(__FILE__), "../config/0single.yml")))
CONFIG['user'] = ENV['BROWSERSTACK_USERNAME'] || CONFIG['user']
CONFIG['key'] = ENV['BROWSERSTACK_ACCESS_KEY'] || CONFIG['key']


RSpec.configure do |config|
  config.around(:example) do |example|
    @caps = CONFIG['common_caps'].merge(CONFIG['browser_caps'][TASK_ID])
    @caps["name"] = ENV['name'] || example.metadata[:name] || example.metadata[:file_path].split('/').last.split('.').first
    enable_local = @caps["browserstack.local"] && @caps["browserstack.local"].to_s == "true"

    # Code to start browserstack local before start of test
    if enable_local
      @bs_local = BrowserStack::Local.new
      bs_local_args = { "key" => CONFIG['key'], "forcelocal" => true }
      @bs_local.start(bs_local_args)
      @caps["browserstack.local"] = true
    end

    @driver = Selenium::WebDriver.for(:remote,
      :url => "http://#{CONFIG['user']}:#{CONFIG['key']}@#{CONFIG['server']}/wd/hub",
      :desired_capabilities => @caps)

    begin
      example.run
    ensure
      @driver.quit
      # Code to stop browserstack local after end of test
      @bs_local.stop if enable_local
    end
  end
end

describe 'Loads up correctly', :type => :feature do
#  before :each do
#    Capybara.current_driver = :firefox
#  end
  it 'FIREFOX has the expected search input field' do
    visit( @root )
    search_button_on_page=@driver.find(:css, "input[aria-label='Search']")
    expect(@driver.search_button_on_page).to be
  end
  it 'Shows results' do
    visit( @root )
    find(:css, "input[aria-label='Search']").set("123")
    find(:css, "input[aria-label='Search']").send_keys :enter
    expect(@driver.page).to have_content 'results'
  end
end

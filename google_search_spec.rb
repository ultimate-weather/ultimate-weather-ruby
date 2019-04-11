require 'rspec'
require 'capybara'
require 'capybara/rspec'
require 'capybara/dsl'

Capybara.run_server = false
Capybara.default_driver = :selenium
Capybara.app_host = 'http://www.google.com'

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

root='/'

describe 'Loads up correctly', :type => :feature do
  before :each do
    Capybara.current_driver = :chrome
  end
  it 'Has the expected search input field' do
    visit( root )
    search_button_on_page=find(:css, "input[aria-label='Search']")
    expect(search_button_on_page).to be
  end
  it 'Shows results' do
    visit( root )
    find(:css, "input[aria-label='Search']").set("123\n")
    expect(page).to have_content 'results'
  end
end

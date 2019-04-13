describe 'IE browser loads correctly', :type => :feature do
	before :each do |scenario|
    Capybara.app_host = 'http://www.bing.com'
    Capybara.current_driver = :browserstack
	end

  it 'IE browser has the expected search input field' do
    visit( @root )
    search_button_on_page=find(:css, "input[name='q']")
    expect(search_button_on_page).to be
  end
  it 'IE browser shows results', :happy do
    visit( @root )
    find(:css, "input[name='q']").send_keys "123"
sleep 2 # or intermittent failures
    find(:css, "input[name='q']").send_keys :enter
sleep 3
    expect(page).to have_content 'result'
  end
end

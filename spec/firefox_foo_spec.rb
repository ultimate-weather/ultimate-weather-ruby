describe 'Firefox browser loads correctly', :type => :feature do
  before :each do
    Capybara.current_driver = :firefox
  end
  it 'Firefox browser has the expected search input field' do
    visit( @root )
    search_button_on_page=find(:css, "input[aria-label='Search']")
    expect(search_button_on_page).to be
  end
  it 'Firefox browser shows results' do
    visit( @root )
    find(:css, "input[aria-label='Search']").set("123")
    find(:css, "input[aria-label='Search']").send_keys :enter
    expect(page).to have_content 'results'
  end
end

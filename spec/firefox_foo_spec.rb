describe 'FIREFOX Browser loads up correctly', :type => :feature do
  before :each do
    Capybara.current_driver = :firefox
  end
  it 'FIREFOX has the expected search input field' do
    visit( @root )
    search_button_on_page=find(:css, "input[aria-label='Search']")
    expect(search_button_on_page).to be
  end
  it 'FIREFOX Shows results' do
    visit( @root )
    find(:css, "input[aria-label='Search']").set("123")
    find(:css, "input[aria-label='Search']").send_keys :enter
    expect(page).to have_content 'results'
  end
end

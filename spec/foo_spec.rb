describe 'Loads up correctly', :type => :feature do
  before :each do
    Capybara.current_driver = :chrome
  end
  it 'Has the expected search input field' do
    visit( @root )
    search_button_on_page=find(:css, "input[aria-label='Search']")
    expect(search_button_on_page).to be
  end
  it 'Shows results' do
    visit( @root )
    find(:css, "input[aria-label='Search']").set("123\n")
    expect(page).to have_content 'results'
  end
end

describe 'Chrome browser loads correctly', type: :feature do
  before :each do
    Capybara.current_driver = :chrome
  end
  it 'Chrome browser has the expected search input field' do
    visit(@root)
    search_button_on_page = find(:css, "input[aria-label='Search']")
    expect(search_button_on_page).to be
  end
  it 'Chrome browser shows results', :happy do
    visit(@root)
    find(:css, "input[aria-label='Search']").set("123\n")
    expect(page).to have_content 'results'
  end
end

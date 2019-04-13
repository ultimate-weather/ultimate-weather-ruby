describe 'Default browser is chrome and loads up correctly', :type => :feature do
  it 'Default browser has the expected search input field' do
    visit( @root )
    search_button_on_page=find(:css, "input[aria-label='Search']")
    expect(search_button_on_page).to be
  end
  it 'CHROME shows results' do
    visit( @root )
    find(:css, "input[aria-label='Search']").set("123\n")
    expect(page).to have_content 'results'
  end
end

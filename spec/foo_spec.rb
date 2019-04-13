describe 'Default browser is Chrome and loads correctly', :type => :feature do
  it 'Default browser is Chrome and has the expected search input field' do
    visit( @root )
    search_button_on_page=find(:css, "input[aria-label='Search']")
    expect(search_button_on_page).to be
  end
  it 'Default browser is Chrome and shows results' do
    visit( @root )
    find(:css, "input[aria-label='Search']").set("123\n")
    expect(page).to have_content 'results'
  end
end

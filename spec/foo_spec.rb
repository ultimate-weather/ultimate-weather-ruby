describe 'Default browser is Chrome and loads correctly', :type => :feature do
  it 'Default browser is Chrome' do
    visit( @root )
    expect(page.driver.browser.to_s).to match(/WebDriver.*Chrome/)
  end
end

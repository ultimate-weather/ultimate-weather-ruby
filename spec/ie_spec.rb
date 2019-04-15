describe 'IE browser loads correctly', type: :feature do
  it 'IE browser has the expected search input field on bing.com', :ie do
    if ENV['TEST_IE'] == 'true'
      Capybara.current_driver = :browserstack
      Capybara.app_host = 'http://www.bing.com'
      visit(@root)
      search_button_on_page = find(:css, "input[name='q']")
      expect(search_button_on_page).to be
    else
      expect(true).to be
    end
  end

  it 'IE for w3.org', :ie do
    if ENV['TEST_IE'] == 'true'
      Capybara.current_driver = :browserstack
      Capybara.app_host = 'http://www.w3.org'
      visit @root
      expect(page).to have_content 'The World Wide Web Consortium'
    else
      expect(true).to be true
    end
  end
end

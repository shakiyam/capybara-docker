require_relative '../spec_helper'

Capybara.app_host = 'https://github.com'

feature 'Remote test' do
  scenario 'Access this project page' do
    visit '/shakiyam/capybara-docker/'
    expect(page).to have_content 'capybara-docker'
    click_link 'Go to file'
  end
end

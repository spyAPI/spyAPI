require 'rails_helper'

feature 'updating an API' do
  before do
    sign_up
    add_api
  end
  scenario 'user can update an API key linked to their account' do
    key = Api.last.key
    visit '/'
    click_link 'Test API'
    click_link 'Edit API'
    check 'key_api'
    click_button 'Update Api'
    expect(page).to have_content 'name: Test API'
    expect(page).not_to have_content key
    expect(page).to have_content Api.last.key
  end
  scenario 'user can update an API name linked to their account' do
    key = Api.last.key
    visit '/'
    click_link 'Test API'
    click_link 'Edit API'
    fill_in 'Name', with: 'New API'
    click_button 'Update Api'
    expect(page).to have_content 'name: New API'
    expect(page).not_to have_content 'name: Test API'
    expect(page).to have_content key
  end
end
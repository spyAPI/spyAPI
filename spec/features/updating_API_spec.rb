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

  scenario 'user can delete an API linked to their account' do
    visit '/'
    click_link 'Test API'
    click_link 'Delete API'
    expect(page).not_to(have_content("Test API"))
    expect(page).to have_content 'API successfully deleted'
  end

  scenario 'JSONs associated with the API are also deleted when an API is deleted' do
    visit '/'
    click_link 'Test API'
    click_link 'Add JSON'
    fill_in 'Name', with: "Test 1"
    fill_in 'Content', with: "String for testing"
    click_button 'Create Json'
    click_link 'Delete API'
    expect(page).not_to(have_content("Test 1"))
  end


end

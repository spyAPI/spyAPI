require 'rails_helper'

feature 'adding an API' do
  scenario 'user can add a new API to thier account' do
    sign_up
    visit '/'
    click_link 'add API'
    expect(current_path).to eq '/apis/new'
    fill_in 'Name', with: 'Test API'
    click_button 'Create Api'
    expect(page).to have_content 'name: Test API'
  end
end

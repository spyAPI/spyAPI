require 'rails_helper'

feature 'adding an API' do
  scenario 'user can add a new API to thier account' do
    sign_up
    visit '/'
    click_link 'add API'
    expect(current_path).to eq '/apis/new'
    fill_in 'Name', with: 'Test API'
    click_button 'Generate API key'
    expect(page).to have_content 'Test API'
    expect(page).to have_content 'your new API key is'
  end
end

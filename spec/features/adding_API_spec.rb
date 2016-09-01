require 'rails_helper'

feature 'adding an API' do
  scenario 'user can add a new API to their account' do
    sign_up
    visit '/'
    click_link 'add API'
    expect(current_path).to eq '/apis/new'
    fill_in 'Name', with: 'Test API'
    click_button 'Create Api'
    expect(page).to have_link 'Test API'
  end

  context 'User is able to view their own API' do
    before do
      sign_up
      click_link 'add API'
      fill_in 'Name', with: 'Test API'
      click_button 'Create Api'
    end

    scenario ' User can see their own API' do
      expect(page).to have_content('Test API')
      expect(current_path).to eq ('/')
    end

    scenario ' User cannot see another users API' do
      sign_out
      sign_up(email: 'another@test.com')
      click_link 'add API'
      fill_in 'Name', with: 'Second API'
      click_button 'Create Api'
      expect(page).to have_content('Second API')
      expect(page).not_to have_content('Test API')
      expect(current_path).to eq ('/')
    end
  end
end

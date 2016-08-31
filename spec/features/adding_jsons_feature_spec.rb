require 'rails_helper'

feature 'adding JSONs' do
  before do
    sign_up
    add_api
  end

  context 'there are no JSONs by default' do
    scenario 'no JSONs to view' do
      visit '/'
      click_link 'Test API'
      expect(current_path).to eq("/apis/#{Api.last.id}")
      expect(page).to have_content 'No JSONs yet'
      expect(page).to have_link 'Add JSON'
    end
  end

  context 'creating JSONs' do
    scenario 'user can create a JSON' do
      visit '/'
      click_link 'Test API'
      click_link 'Add JSON'
      fill_in 'Name', with: 'Test-data'
      fill_in 'Content', with: '{"message":"hello world"}'
      click_button 'Create Json'
    end
  end


end

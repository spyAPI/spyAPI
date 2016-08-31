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



end

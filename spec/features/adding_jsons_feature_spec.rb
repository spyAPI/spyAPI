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


  context 'viewing JSONs' do
    scenario 'user can view JSON' do
      add_JSON
      expect(page).to have_content '{"message":"hello world"}'
    end
  end

  context 'editing JSONs' do
    scenario 'user can update a JSON' do
      add_JSON
      click_link 'Edit JSON'
      fill_in 'Name', with: 'More test-data'
      fill_in 'Content', with: '{"different message":"goodbye world"}'
      click_button 'Update Json'
      expect(page).to have_content '{"different message":"goodbye world"}'
      expect(page).not_to have_content '{"message":"hello world"}'
    end
  end

  context 'deleting JSONs' do
    scenario 'user can delete a JSON' do
      add_JSON
      click_link 'Delete JSON'
      expect(page).not_to have_content '{"message":"hello world"}'
      expect(page).to have_content 'JSON successfully deleted'

    end
  end

  context 'JSON validation' do
    scenario 'attempting to add an incorrectly formatted JSON' do
      add_JSON(content: 'this is not a json')
      expect(page).to have_content('Content is not a valid JSON')
      expect(current_path).to eq "/apis/#{Api.last.id}/jsons"
    end
    scenario 'attempting to add an incorrectly formatted JSON, then correcting it' do
      add_JSON(content: 'this is not a json')
      fill_in 'Content', with: '{"status":"correct"}'
      click_button 'Create Json'
      expect(page).to have_content '{"status":"correct"}'
      expect(page).not_to have_content('Content is not a valid JSON')

    end
  end


end

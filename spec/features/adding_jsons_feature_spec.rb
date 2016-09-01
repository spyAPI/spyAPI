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
    scenario 'user can view JSON on its own page' do
      add_JSON
      expect(page).to have_link 'Test-data'
      click_link 'Test-data'
      expect(page).to have_content '{"message":"hello world"}'
    end


    scenario 'JSON pages have the api link' do
      add_JSON
      expect(page).to have_link 'Test-data'
      click_link 'Test-data'
      expect(page).to have_content 'API url:'
      expect(page).to have_content "/apis?api-key=#{Api.last.key}&json=Test-data"
    end

  end

  context 'editing JSONs' do
    scenario 'user can update a JSON' do
      add_JSON
      click_link 'Test-data'
      click_link 'Edit JSON'
      fill_in 'Name', with: 'More test-data'
      fill_in 'Content', with: '{"different message":"goodbye world"}'
      click_button 'Update Json'
      expect(page).to have_link 'More test-data'
      click_link 'More test-data'
      expect(page).to have_content '{"different message":"goodbye world"}'
      expect(page).not_to have_content '{"message":"hello world"}'
    end
  end

  context 'deleting JSONs' do
    scenario 'user can delete a JSON' do
      add_JSON
      click_link 'Test-data'
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
      click_link 'Test-data'
      expect(page).to have_content '{"status":"correct"}'
      expect(page).not_to have_content('Content is not a valid JSON')

    end
  end

  context 'JSON names associated with an API key must be unique' do
    it 'does not allow a user to save the same JSON name twice on a single API' do
      add_JSON
      add_JSON
      expect(page).to(have_content('Name has already been used'))
      expect(current_path).to(eq("/apis/#{Api.last.id}/jsons"))
    end
    it 'does allow a user to save the same JSON name on different APIs' do
      add_JSON
      expect(page).to(have_content('Test-data'))
      add_api(name: "Second test API")
      add_JSON(link: "Second test API")
      expect(page).to(have_content('Test-data'))
    end
  end


end

require 'rails_helper'

feature 'spyAPI' do
  context 'no API key is given' do
    scenario 'error message is returned when no API key is given' do
      visit '/apis?'
      expect(page).to have_content('{"message":"No API Key found in headers, body or querystring"}')
    end
  end
  context 'API key is given' do
    before do
      api = Api.create(key: 'abcdefghijklmnopqrstuvwxyz0123456789')
      Json.create(name: 'test-data', content: "Hello, World!", api_id: api.id)
    end
    scenario 'JSON is returned' do
      visit '/apis?api-key=abcdefghijklmnopqrstuvwxyz0123456789&json=test-data'
      expect(page).to have_content('Hello, World!')
      expect(page).not_to have_content('{"message":"No API Key found in headers, body or querystring"}')
    end
  end
  context 'API key is given' do
    before do
      api = Api.create(key: 'abcdefghijklmnopqrstuvwxyz0123456789')
      Json.create(name: 'test-data', content: "Hello, World!", api_id: api.id)
      Json.create(name: 'test-data2', content: "Hello, World, again!", api_id: api.id)
    end
    scenario 'specific JSON is returned' do
      visit '/apis?api-key=abcdefghijklmnopqrstuvwxyz0123456789&json=test-data2'
      expect(page).to have_content('Hello, World, again!')
      expect(page).not_to have_content('{"message":"No API Key found in headers, body or querystring"}')
    end
  end
end

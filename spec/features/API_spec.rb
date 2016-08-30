require 'rails_helper'

feature 'spyAPI' do
  context 'no API key is given' do
    scenario 'error message is returned when no API key is given' do
      visit '/api?'
      expect(page).to have_content('{"message":"No API Key found in headers, body or querystring"}')
    end
  end
  context 'API key is given' do
    before do
      api = Api.create(key: 'abcdefghijklmnopqrstuvwxyz0123456789')
      json = Json.create(name: 'test-data', content: "Hello, World!")
      json.api = api
      json.save
      p '==============='
      p api.jsons[0]
      p '================'

    end
    scenario 'JSON is returned' do
      visit '/api?api-key=abcdefghijklmnopqrstuvwxyz0123456789&json=test-data'
      expect(page).to have_content('Hello, World!')
      expect(page).not_to have_content('{"message":"No API Key found in headers, body or querystring"}')
    end
  end
end

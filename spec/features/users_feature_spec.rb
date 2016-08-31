require 'rails_helper'

feature 'User can sign in and out' do
  context 'user not signed in and on the homepage' do
    it 'should see sign in link and signup link' do
      visit ('/')
      expect(page).to have_link 'Sign in'
      expect(page).to have_link 'Sign up'
    end

    it 'should not see sign out link' do
      visit('/')
      expect(page).not_to have_link 'Sign out'
    end

  end

  context 'User signed in on the homepage' do
    before do
      visit '/'
      click_link 'Sign up'
      fill_in 'Email', with: "test@example.com"
      fill_in 'Password', with: "secret"
      fill_in 'Password confirmation', with: "secret"
      click_button 'Sign up'
    end

    it 'should see Sign out link' do
      visit '/'
      expect(page).to(have_link("Sign out"))
    end

    it 'should not see a Sign in or Sign up link' do
      visit '/'
      expect(page).not_to(have_link("Sign up"))
      expect(page).not_to(have_link("Sign in"))
    end
  end
end

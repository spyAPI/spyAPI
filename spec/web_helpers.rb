def sign_up
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: "test@example.com"
  fill_in 'Password', with: "secret"
  fill_in 'Password confirmation', with: "secret"
  click_button 'Sign up'
end

def sign_up(email: 'test@example.com')
  visit '/'
  click_link 'Sign up'
  fill_in 'Email', with: email
  fill_in 'Password', with: "secret"
  fill_in 'Password confirmation', with: "secret"
  click_button 'Sign up'
end


def sign_out
  visit '/'
  click_link 'Sign out'
end

def add_api
  click_link 'add API'
  fill_in 'Name', with: 'Test API'
  click_button 'Create Api'
end

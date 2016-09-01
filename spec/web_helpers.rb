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

def add_api(name: 'Test API')
  click_link 'add API'
  fill_in 'Name', with: name
  click_button 'Create Api'
end

def add_JSON(content: '{"message":"hello world"}', link: 'Test API')
  visit '/'
  click_link link
  click_link 'Add JSON'
  fill_in 'Name', with: 'Test-data'
  fill_in 'Content', with: content
  click_button 'Create Json'
end



def signup
  visit '/users/new'
  fill_in(:email,    with: 'test@yahoo.com')
  fill_in(:password, with: 'test123')
  fill_in(:password_confirmation, with: 'test123')
  click_button('sign up')
end

def false_signup
  visit '/users/new'
  fill_in(:email,    with: 'test@yahoo.com')
  fill_in(:password, with: 'test123')
  fill_in(:password_confirmation, with: 'test12')
  click_button('sign up')
end

def no_email_signup
  visit '/users/new'
  fill_in(:email,    with: '')
  fill_in(:password, with: 'test123')
  fill_in(:password_confirmation, with: 'test123')
  click_button('sign up')
end

def invalid_email_signup
  visit '/users/new'
  fill_in(:email,    with: 'invalid_email')
  fill_in(:password, with: 'test123')
  fill_in(:password_confirmation, with: 'test123')
  click_button('sign up')
end

def sign_in
  visit '/sessions/new'
  fill_in(:email,    with: 'test@yahoo.com')
  fill_in(:password, with: 'test123')
  click_button('sign in')
end

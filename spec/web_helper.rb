

def signup
  visit '/users/new'
  fill_in(:email,    with: 'test@yahoo.com')
  fill_in(:password, with: 'test123')
  click_button('sign up')
end

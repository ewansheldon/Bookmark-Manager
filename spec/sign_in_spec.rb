require 'spec_helper'

feature 'sign in' do
  before(:each) do
    signup
    Capybara.reset_sessions!
  end
  scenario 'user signs in' do
    sign_in
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome, test@yahoo.com'
  end
end

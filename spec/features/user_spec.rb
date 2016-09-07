require 'spec_helper'
require 'data_mapper'
require 'dm-postgres-adapter'
#require_relative '../data_mapper_setup'

feature 'tests the user stuff' do

  scenario 'I can sign up as a new user' do
    expect {sign_up}.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end


end

feature 'password confirmation' do
  scenario "error message when password confirmation doesn't match password" do
    visit '/users/new'
    expect(page.status_code).to eq 200
    fill_in :email, with: 'alice@example.com'
    fill_in :password, with: 'oranges!'
    fill_in :password_confirmation, with: 'apples!'
    click_button 'Sign up'
    expect(page).to have_content("Password confirmation and password do not match")
  end
end

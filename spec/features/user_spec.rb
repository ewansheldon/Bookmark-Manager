require 'spec_helper'
require 'data_mapper'
require 'dm-postgres-adapter'
#require_relative '../data_mapper_setup'

feature 'tests the user stuff' do

  scenario 'homepage signup' do
    visit '/users/new'
    fill_in('email', with: 'something@example.com')
    fill_in('password', with: 'password')
    click_button('submit')
    users = User.all
    expect{users.count}.to change_by{1}
  end

  scenario 'I can sign up as a new user' do
    expect {sign_up}.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.eamil).to eq('alice@example.com')
  end


end

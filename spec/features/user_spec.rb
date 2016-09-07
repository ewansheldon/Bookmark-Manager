require 'spec_helper'
require 'data_mapper'
require 'dm-postgres-adapter'
#require_relative '../data_mapper_setup'

feature 'tests the user stuff' do

  scenario 'I can sign up as a new user' do
    expect {sign_up}.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.eamil).to eq('alice@example.com')
  end


end

require 'spec_helper'
require_relative 'web_helper'

feature 'user sign up' do

  scenario "I can sign up as a new user" do
    expect { signup }.to change(User, :count).by(1)
    expect(page.status_code).to eq(200)
    expect(page).to have_content('Welcome, test@yahoo.com')
    expect(User.first.email).to eq('test@yahoo.com')
  end

  scenario "I cant sign up if my passwords dont match" do
    expect {false_signup}.not_to change(User, :count)
    expect(page.status_code).to eq(200)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Password and confirmation password do not match')
  end

  scenario "user cannot create account with blank email" do
    expect {no_email_signup}.not_to change(User, :count)
    expect(page.status_code).to eq(200)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Must enter a valid email address')
  end

  scenario "user cannot create account with a invalid email" do
    expect {invalid_email_signup}.not_to change(User, :count)
    expect(page.status_code).to eq(200)
    expect(current_path).to eq '/users'
  end

  scenario 'cannot create multiple accounts with same email address' do
    signup
    expect {signup}.not_to change(User, :count)
    expect(page.status_code).to eq(200)
    expect(current_path).to eq '/users'
    expect(page).to have_content('Email is already taken')
  end
end

require 'spec_helper'
require 'data_mapper'
require 'dm-postgres-adapter'
#require_relative '../data_mapper_setup'

feature 'tests the user stuff' do

  scenario 'homepage signup' do
    visit '/'
    fill_in('email', with: 'something@example.com')
    fill_in('password', with: 'password')
    click_button('submit')
    users = User.all
    expect{users.count}.to change_by{1}
  end

end

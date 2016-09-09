require 'spec_helper'

feature 'sign out' do
  scenario 'it signs you out' do
    signup
    click_button 'sign out'
    expect(page).to have_content 'See you again soon!'
    expect(current_path).to eq '/sessions/new'
    expect(page).not_to have_content 'test@yahoo.com'
  end
end

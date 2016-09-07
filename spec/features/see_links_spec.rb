require 'spec_helper'

feature 'To see a list of links of the homepage' do

  DatabaseCleaner.strategy = :truncation

  before :each do
    DatabaseCleaner.clean
  end

  after :each do
    DatabaseCleaner.clean
  end

  scenario 'a user visits the homepage, they will see a list of links' do
    Link.create(url: 'http://www.makersacademy.com', title: 'Makers Academy')
    visit '/links'
    expect(page.status_code).to eq 200
    within 'ul#links' do
    expect(page).to have_content('Makers Academy')
    end
  end

  scenario 'user can add a new link' do
    visit '/links/new'
    fill_in('bookmark_title', with: 'Yahoo')
    fill_in('link_url', with: 'www.yahoo.com')
    click_button('Submit')
    visit '/links'
    within 'ul#links' do
      expect(page).to have_content('Yahoo')
    end
  end

  scenario 'user can add a tag to a new link' do
    visit '/links/new'
    fill_in('bookmark_title', with: 'Yahoo')
    fill_in('link_url', with: 'www.yahoo.com')
    fill_in('tag_name', with: 'Important')
    click_button('Submit')
    # visit '/links'
    # within 'ul#links' do
    #   expect(page).to have_content('Important')
    link = Link.first
   expect(link.tags.map(&:name)).to include('Important')
    # end
  end

  scenario 'user can see links by filtering via the URL' do
    visit '/links/new'
    fill_in('bookmark_title', with: 'Yahoo')
    fill_in('link_url', with: 'www.yahoo.com')
    fill_in('tag_name', with: 'Important')
    click_button('Submit')

    visit '/links/new'
    fill_in('bookmark_title', with: 'Google')
    fill_in('link_url', with: 'www.google.com')
    fill_in('tag_name', with: 'bubbles')
    click_button('Submit')

    expect(page.status_code).to eq(200)

    visit '/tags/bubbles'
    within 'ul#links' do
      expect(page).to have_content('Google')
      expect(page).not_to have_content('Yahoo')
    end
  end

  scenario 'user can add multiple tags to a link' do
    visit '/links/new'
    fill_in('bookmark_title', with: 'Google')
    fill_in('link_url', with: 'www.google.com')
    fill_in('tag_name', with: 'bubbles search')
    click_button('Submit')
    link = Link.first
    expect(link.tags.map(&:name)).to include('bubbles', 'search')
  end
end

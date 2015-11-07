require 'rails_helper'

  def sign_up_user_one
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: 'ben@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
  end

  def sign_out
    visit '/'
    click_link 'Sign out'
  end

  def sign_up_user_two
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: 'bob@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
  end

  def sign_up_user_three
    visit '/'
    click_link 'Sign up'
    fill_in 'user[email]', with: 'bill@test.com'
    fill_in 'user[password]', with: 'password'
    fill_in 'user[password_confirmation]', with: 'password'
    click_button 'Sign up'
  end

  def create_listing_one
    visit '/listings/new'
    fill_in 'listing[title]', with: '1959 Les Paul'
    fill_in 'listing[subtitle]', with: 'A true gem with OHSC'
    fill_in 'listing[description]', with: 'Test description'
    click_button 'Create Listing'
  end

  def create_listing_two
    visit '/listings/new'
    fill_in 'listing[title]', with: '1970 CBS Strat'
    fill_in 'listing[subtitle]', with: 'Olympic White'
    fill_in 'listing[description]', with: 'Test description'
    click_button 'Create Listing'
  end

  def create_listing_three
    visit '/listings/new'
    fill_in 'listing[title]', with: 'Takamine'
    fill_in 'listing[subtitle]', with: 'MIJ'
    fill_in 'listing[description]', with: 'Test description'
    click_button 'Create Listing'
  end

  def add_listing_one_to_watchlist
    visit '/listings'
    click_link '1959 Les Paul'
    click_link 'Add to my watchlist - 1959 Les Paul'
  end

  def add_listing_two_to_watchlist
    visit '/listings'
    click_link '1970 CBS Strat'
    click_link 'Add to my watchlist - 1970 CBS Strat'
  end


feature "User can sign in and out" do
  context "user not signed in and on the homepage" do
    it "should see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).to have_link('Sign in')
      expect(page).to have_link('Sign up')
    end

    it "should not see 'sign out' link" do
      visit('/')
      expect(page).not_to have_link('Sign out')
    end
  end

  context "user signed in on the homepage" do
    before do
      sign_up_user_one
    end

    it "should see 'sign out' link" do
      visit('/')
      expect(page).to have_link('Sign out')
    end

    it "should not see a 'sign in' link and a 'sign up' link" do
      visit('/')
      expect(page).not_to have_link('Sign in')
      expect(page).not_to have_link('Sign up')
    end

    it "should see a link to view their profile" do
      visit '/'
      expect(page).to have_link 'My Profile'
    end
  end

  context "user signed in and on their my profile page" do
    before do
      sign_up_user_one
    end

    it "should navigate to their profile page" do
      visit '/'
      click_link 'My Profile'
      expect(page).to have_content 'ben@test.com'
    end
  end

  context "user signed in and on their my profile page" do
    before do
      sign_up_user_one
      sign_out
      sign_up_user_two
      sign_out
      sign_up_user_three
    end

    it "should navigate to their profile page" do
      visit '/'
      click_link 'Users'
      expect(page).to have_content 'ben@test.com'
      expect(page).to have_content 'bob@test.com'
      expect(page).to have_content 'bill@test.com'
    end
  end

  context "user watchlist" do
    before do
      sign_up_user_one
      create_listing_one
      create_listing_two
      create_listing_three
      sign_out
      sign_up_user_two
    end

    it "should display all their currently watched items" do
      add_listing_one_to_watchlist
      add_listing_two_to_watchlist
      visit '/' 
      click_link "My Watch List"
      expect(page).to have_content '1959 Les Paul'
      expect(page).to have_content '1970 CBS Strat'
      expect(page).not_to have_content 'Takamine'
    end

    it "can remove a currently watched item from the list" do
      add_listing_one_to_watchlist
      add_listing_two_to_watchlist
      visit '/' 
      click_link "My Watch List"
      click_link 'Remove from watchlist - 1959 Les Paul'
      expect(page).to have_content '1970 CBS Strat'
      expect(page).to have_content 'Listing successfully removed from your watch list'
      expect(page).not_to have_content '1959 Les Paul'
    end

    it "can add, remove and re-add a listing to watched item list" do
      visit '/' 
      click_link "My Watch List"
      expect(page).to have_content 'No items in your watchlist yet :('
      add_listing_one_to_watchlist
      click_link "My Watch List"
      expect(page).to have_content '1959 Les Paul'
      click_link 'Remove from watchlist - 1959 Les Paul'
      expect(page).to have_content 'No items in your watchlist yet :('
      add_listing_one_to_watchlist
      click_link "My Watch List"
      expect(page).to have_content '1959 Les Paul'
    end

    it "can link straight to the listing a watched item" do
      add_listing_one_to_watchlist
      visit '/' 
      click_link "My Watch List"
      click_link "1959 Les Paul"
      # expect(current_path).to eq listing_path(listing)
      expect(page).to have_content 'A true gem with OHSC'
    end
  end
end
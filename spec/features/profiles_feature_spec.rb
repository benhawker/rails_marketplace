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


feature "Profile" do
  context "user has created their account" do

    it "can fill in and save their profile information" do
      sign_up_user_one
      click_link "Edit Profile"
      fill_in 'profile[city]', with: "London"
      fill_in 'profile[country]', with: "UK"
      click_button "submit"
      expect(page).to have_content("Profile for ben@test.com")
      expect(page).to have_content("London")
      expect(page).to have_content("UK")
    end

  end
end
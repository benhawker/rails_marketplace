require 'rails_helper'

feature 'buying & watching' do

	def sign_up_user_one
	  visit '/'
	  click_link 'Sign up'
	  fill_in 'user[email]', with: 'ben@test.com'
	  fill_in 'user[password]', with: 'password'
	  fill_in 'user[password_confirmation]', with: 'password'
	  click_button 'Sign up'
	end

	def sign_in_user_one
	  visit '/'
	  click_link 'Sign in'
	  fill_in 'user[email]', with: 'ben@test.com'
	  fill_in 'user[password]', with: 'password'
	  click_button 'Log in'
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

	def sign_up_user(user)
	  visit '/'
	  click_link 'Sign up'
	  fill_in 'user[email]', with: user.email
	  fill_in 'user[password]', with: user.password
	  fill_in 'user[password_confirmation]', with: user.password_confirmation
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


  context 'listings have been added' do
	  before do
	  	sign_up_user_one
	    create_listing_one
	  end

	  scenario 'user adds item to watchlist & is shown flash notice confirmation' do
	    visit '/listings'
			click_link '1959 Les Paul'
			click_link 'Add to my watchlist - 1959 Les Paul'
			expect(page).to have_content 'Listing was successfully added to your watchlist'
	    expect(page).not_to have_content('No listings yet')
	  end

	  scenario 'user trys to add duplicate item to watchlist & is shown flash notice saying it is already added' do
	    visit '/listings'
			click_link '1959 Les Paul'
			click_link 'Add to my watchlist - 1959 Les Paul'
			expect(page).to have_content 'This listing is in your watchlist'
	  end
	end
end
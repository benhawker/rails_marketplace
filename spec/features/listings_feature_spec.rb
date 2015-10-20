require 'rails_helper'

feature 'listings' do

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

	  scenario 'display listings' do
	    visit '/listings'
	    expect(page).to have_content('1959 Les Paul')
	    expect(page).not_to have_content('No listings yet')
	  end
	end

	context 'creating listings' do
		before do
	  	sign_up_user_one
	    create_listing_one
	  end

	  scenario 'prompts user to fill out a form, then displays the new listing' do
	    visit '/listings'
	    click_link 'Add a listing'
	    fill_in 'Title', with: '1959 Les Paul'
	    click_button 'Create Listing'
	    expect(page).to have_content '1959 Les Paul'
	    expect(current_path).to eq '/listings'
	  end
	end

	context 'viewing listings' do

		before do
	  	sign_up_user_one
	    create_listing_one
	  end

	  scenario 'lets a user view a listing' do
	   visit '/listings'
	   click_link '1959 Les Paul'
	   expect(page).to have_content '1959 Les Paul'
	  end
	end

	context 'searching listings' do

		before do
	  	sign_up_user_one
	    create_listing_one
	    create_listing_two
	  end

	  scenario 'lets a user view a listing' do
	   visit '/listings'
	   fill_in 'search', with: 'Les Paul'
	   click_button 'Search'
	   expect(page).to have_content '1959 Les Paul'
	   expect(page).not_to have_content '1970 CBS Strat'
	  end
	end

	context 'editing listings' do

		before do
	  	sign_up_user_one
	    create_listing_one
	  end

	  # let!(:user){ User.create(email: "ben@test.com", password: "password", password_confirmation: "password") }
	  # let!(:listing){user.listings.create(title:'1959 Les Paul')}

	  scenario 'let a listing owner edit their own listing' do
			visit '/listings'
			click_link '1959 Les Paul'
			click_link 'Edit 1959 Les Paul'
			fill_in 'listing[title]', with: '1970 CBS Strat'
			click_button 'Update Listing'
			expect(page).to have_content 'Your listing was successfully updated'
	  end

	  scenario 'user see edit link to anothers listing' do
	  	sign_out
			sign_up_user_two
			visit '/listings'
			click_link '1959 Les Paul'
			expect(page).not_to have_content 'Edit your listing'
	  end

	 	scenario 'user cannot edit anothers listing' do
			visit '/listings'
			click_link '1959 Les Paul'
	  end
	end

	context 'deleting listings' do

		before do
	  	sign_up_user_one
	    create_listing_one
	  end

	  scenario 'removes a listing when the listing owner clicks a delete link' do
	    visit '/listings'
	    click_link '1959 Les Paul'
	    click_link 'Delete 1959 Les Paul'
	    expect(page).not_to have_content '1959 Les Paul'
	    expect(page).to have_content 'Your listing was successfully deleted'
	  end

	  scenario 'user see delete link to anothers listing' do
	  	sign_out
			sign_up_user_two
			visit '/listings'
			click_link '1959 Les Paul'
			expect(page).not_to have_content 'Delete 1959 Les Paul'
	  end

	  # scenario 'user cannot delete anothers listing' do
	  # 	#this should be a unit test checking validation vs the DB.
	  # end
	end
end
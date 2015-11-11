require 'rails_helper'

feature 'listings' do
	let!(:user) { FactoryGirl.create(:user) }
  let!(:category) { FactoryGirl.create(:category) }
  let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }
  let!(:user_two) { FactoryGirl.create(:user, :bob) }

  context 'listings have been added' do

	  before { login_as(user, :scope => :user) }

	  scenario 'displays listings' do
	    visit listings_path
	    expect(page).to have_content('1959 Les Paul')
	    expect(page).to have_content('ben@test.com')
	    expect(page).not_to have_content('No listings yet')
	  end
	end

	context 'creating listings' do
		before { login_as(user, :scope => :user) }

		context "listing filled out correctly" do
		  scenario 'prompts user to fill out a form, then displays the new listing' do
		    visit '/listings'
		    click_link 'Add a listing'
		    fill_in 'Title', with: '1959 Les Paul'
		    fill_in 'Subtitle', with: "Subtitle"
		    fill_in "Price", with: '100'
		    fill_in "Location", with: 'London'
		    attach_file 'listing[photos_attributes][0][image]', 'spec/test.jpg'
		    click_button 'Create Listing'
		    expect(page).to have_content '1959 Les Paul'
		    expect(current_path).to eq '/listings'
		  end

		  scenario 'user can add tags to their new listing' do
		    visit '/listings'
		    click_link 'Add a listing'
		    fill_in 'Title', with: 'Takamine EN10C'
		    fill_in 'Tags', with: 'Electric, Vintage, Gibson, Les Paul'
		    fill_in 'Subtitle', with: "Subtitle"
		    fill_in "Price", with: '100'
		    fill_in "Location", with: 'London'
		    attach_file 'listing[photos_attributes][0][image]', 'spec/test.jpg'
		    click_button 'Create Listing'
		    click_link 'Takamine EN10C'
		    expect(page).to have_content 'Electric'
		    expect(page).to have_content 'Vintage'
		    expect(page).to have_content 'Gibson'
		    expect(page).to have_content 'Les Paul'
		  end
		end

		context "listing filled out wrong" do
			before { login_as(user, :scope => :user) }
			
			scenario "user does not include a title to their listing" do
				visit '/listings'
		    click_link 'Add a listing'
		    click_button 'Create Listing'
		    expect(current_path).to eq listings_path
		    expect(page).to have_content "Please add a title"
			end
		end

	end

	context 'viewing listings' do
		let!(:profile) { FactoryGirl.create(:profile, user: user) }
	  before { login_as(user_two) }

	  it "lets a user view a listing" do
	   visit listings_path
	   click_link '1959 Les Paul'
	   expect(current_path).to eq listing_path(listing)
	   expect(page).to have_content '1959 Les Paul'
	  end

	  it "lets users view the listing owner's profile direct from the listing" do
	  	visit listings_path
	  	click_link "1959 Les Paul"
	  	click_link "View Seller's Profile"
	  	expect(page).to have_content "ben@test.com"
	  	expect(page).not_to have_content "bob@test.com"
	  end
	end

	context 'searching listings' do
	  scenario 'lets a user view a listing' do
	   visit listings_path
	   fill_in 'search', with: 'Les Paul'
	   click_button 'Search'
	   expect(page).to have_content '1959 Les Paul'
	   expect(page).not_to have_content '1970 CBS Strat'
	  end
	end

	context 'editing listings' do
		before { login_as(user) }
	  
	  it 'let a listing owner edit their own listing' do
			visit listings_path
			click_link '1959 Les Paul'
			click_link 'Edit 1959 Les Paul'
			fill_in 'listing[title]', with: '1970 CBS Strat'
			click_button 'Update Listing'
			expect(page).to have_content 'Your listing was successfully updated'
	  end

	 	before do 
	 		sign_out
	 		login_as(user_two)
	 	end

	  it 'user see edit link to anothers listing' do
			visit listings_path
			click_link '1959 Les Paul'
			expect(page).not_to have_content 'Edit your listing'
	  end

	 	it 'user cannot edit anothers listing' do
			visit listings_path
			click_link '1959 Les Paul'
			#Test to be completed
	  end
	end

	context 'deleting listings' do
		before { login_as(user) }

	  scenario 'removes a listing when the listing owner clicks a delete link' do
	    visit listings_path
	    click_link '1959 Les Paul'
	    click_link 'Delete 1959 Les Paul'
	    expect(page).not_to have_content '1959 Les Paul'
	    expect(current_path).to eq listings_path
	    expect(page).to have_content 'Your listing was successfully deleted'
	  end

	  before do 
	 		sign_out
	 		login_as(user_two)
	 	end

	  scenario 'user see delete link to anothers listing' do
			visit listings_path
			save_and_open_page
			click_link '1959 Les Paul'
			expect(page).not_to have_content 'Delete 1959 Les Paul'
	  end

	  # scenario 'user cannot delete anothers listing' do
	  # 	#this should be a unit test checking validation vs the DB.
	  # end
	end
end

## To be moved out into support/helpers
def sign_out
	visit root_path
	click_link 'Sign out'
end

require 'rails_helper'

feature 'buying & watching' do

  context 'adding items to watchlist' do
		let(:user) { FactoryGirl.create(:user) }
	  let!(:category) { FactoryGirl.create(:category) }
	  let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }
	  let(:user_two) { FactoryGirl.create(:user, :bob) }

	  before { login_as(user) }

	  xit 'user not shown add to watchlist for their own items' do
	    visit listings_path
			click_link '1959 Les Paul'
	    expect(page).not_to have_content('Add to my watchlist - 1959 Les Paul')
	  end


	  before { login_as(user_two) }

	  it 'user adds item to watchlist & is shown flash notice confirmation' do
	    visit listings_path
			click_link '1959 Les Paul'
			click_link 'Add to my watchlist - 1959 Les Paul'
			expect(page).to have_content 'Listing was successfully added to your watchlist'
	    expect(page).not_to have_content('No listings yet')
	  end

	  it  'user trys to add duplicate item to watchlist & is shown flash notice saying it is already added' do
	  	user_watches_listing_one
	    visit listings_path
			click_link '1959 Les Paul'
			click_link 'Add to my watchlist - 1959 Les Paul'
			expect(page).to have_content 'This listing is already in your watchlist'
	  end
	end
end

# To be moved to support/helpers
	def user_watches_listing_one
    visit listings_path
		click_link '1959 Les Paul'
		click_link 'Add to my watchlist - 1959 Les Paul'
	end
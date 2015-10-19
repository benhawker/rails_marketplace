require 'rails_helper'

feature 'listings' do
  context 'no listings have been added' do
    scenario 'should display a prompt to add a listing' do
      visit '/listings'
      expect(page).to have_content 'No listings yet'
      expect(page).to have_link 'Add a listing'
    end
  end

  context 'listings have been added' do
	  before do
	    Listing.create(title: '1959 Les Paul')
	  end

	  scenario 'display listings' do
	    visit '/listings'
	    expect(page).to have_content('1959 Les Paul')
	    expect(page).not_to have_content('No listings yet')
	  end
	end
end
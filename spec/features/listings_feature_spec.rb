require 'rails_helper'

feature 'listings' do
  context 'no listings have been added' do
    scenario 'should display a prompt to add a listing' do
      visit '/listings'
      expect(page).to have_content 'No listings yet'
      expect(page).to have_link 'Add a listing'
    end
  end
end
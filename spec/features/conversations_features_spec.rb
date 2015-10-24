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


feature "Conversations" do
  context "buyer messaging seller about a listing" do
    it "buyer can start a conversation with another user with a question about their listing" do
      sign_up_user_one
      create_listing_one
      sign_out
      sign_up_user_two
      visit "/listings"
      click_link "1959 Les Paul"
      click_link "Contact the Seller"
      expect(page).to have_content "What is your question about?"
      select "Shipping", :from => "question_reason"
      fill_in 'question', with: "How much with Fedex?"
      click_button "Send Message"
      expect(page).to have_content "Your message was successfully sent to the seller"
    end
  end
end
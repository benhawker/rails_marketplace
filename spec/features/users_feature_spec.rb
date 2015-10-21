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
end
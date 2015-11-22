require 'rails_helper'

feature "Profile" do
  context "user has created their account" do

    # Suspect DB not being cleared and a user remains signed in from other tests
    xit "after user sign up page redirects and prompts users to complete their profile information with new user prompt" do
      sign_up_test_user
      expect(page).to have_content "You are now signed up - please complete some profile information about yourself."
    end

    let!(:user) { FactoryGirl.create(:user) }
    before { login_as(user) }

    it "user goes back to edit their profile and is not shown the new user, profile prompt" do
      visit root_path
      click_link 'My Profile'
      click_link 'Edit Profile'
      expect(page).not_to have_content "You are now signed up - please complete some profile information about yourself."
      expect(page).to have_content "Edit your profile and update"
    end

    it "can fill in and save their profile information" do
      visit edit_user_profile_path(user)
      fill_in 'profile[city]', with: "London"
      fill_in 'profile[country]', with: "UK"
      attach_file 'profile[avatar]', 'spec/test.jpg'
      click_button "submit"
      expect(page).to have_content "Profile for ben@test.com"
      expect(page).to have_content "London"
      expect(page).to have_content "UK"
    end
  end

  context "user has created their profile" do

    let!(:user) { FactoryGirl.create(:user) }
    let!(:profile) { FactoryGirl.create(:profile, user: user) }
    before { login_as(user) }

    it "displays the user profile" do
      visit root_path
      click_link "My Profile"
      expect(page).to have_content "ben@test.com"
    end
  end

  context "accessing other user profiles" do
    
    let!(:user) { FactoryGirl.create(:user, :bill) }
    let!(:profile) { FactoryGirl.create(:profile, user: user) }
    let!(:user_two) { FactoryGirl.create(:user, :bob) }
    let!(:profile_two) { FactoryGirl.create(:profile, user: user_two) }
    before { login_as(user_two) }

    it "user does not see edit button for another users profile" do
      visit root_path
      visit user_profile_path(profile)
      expect(page).not_to have_content "Edit Profile"
    end

    it "user is redirected to root path if trying access edit profile path of another user" do
      visit edit_user_profile_path(profile)
      expect(current_path).to eq root_path
      expect(page).to have_content('Access denied! You may only edit your own profile.')
    end
  end

end



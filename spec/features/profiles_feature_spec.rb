require 'rails_helper'

feature "User profiles" do
  context "user has created their account" do
    it "after user sign up page redirects and prompts users to complete their profile information" do
      sign_out
      sign_up_new_user
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
      visit edit_user_path(user)
      fill_in 'user[city]', with: "London"
      attach_file 'user[avatar]', 'spec/test.jpg'
      click_button "submit"
      expect(page).to have_content "Profile for ben@test.com"
      expect(page).to have_content "London"
      expect(page).to have_content "GB"
    end
  end

  context "user has created their profile" do

    let!(:user) { FactoryGirl.create(:user) }
    before { login_as(user) }

    it "displays the user profile" do
      visit root_path
      click_link "My Profile"
      expect(page).to have_content "ben@test.com"
    end
  end

  context "accessing other user profiles" do

    let!(:user) { FactoryGirl.create(:user) }
    let!(:user_two) { FactoryGirl.create(:user, :bob) }
    before { login_as(user) }

    it "user does not see edit button for another users profile" do
      visit root_path
      visit user_path(user_two)
      expect(page).not_to have_content "Edit Profile"
    end

    ## To be completed with Cancan abilities
    xit "user is redirected to root path if trying access edit profile path of another user" do
      visit edit_user_path(user)
      expect(current_path).to eq root_path
      expect(page).to have_content('Access denied! You may only edit your own profile.')
    end
  end

end



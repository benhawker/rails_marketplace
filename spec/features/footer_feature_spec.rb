require 'rails_helper'

feature 'footer' do

  context 'user is on any page' do
	  it "they can visit the about us page" do
	  	visit root_path
	    click_link "About Us"
	    expect(current_path).to eq about_page_path
	  end

	  it "they can visit the about us page" do
	  	visit root_path
	    click_link "Contact Us"
	    expect(current_path).to eq contact_page_path
	  end
	end
end
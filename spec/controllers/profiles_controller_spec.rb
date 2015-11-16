require 'rails_helper'

RSpec.describe ProfilesController, type: :controller do
	describe "#show" do

		let!(:user) { FactoryGirl.create(:user) }
		let!(:profile) { FactoryGirl.create(:profile, user: user) }

    it "shows the right profile" do
			get :show, {user_id: user.id}
      expect(assigns(:profile)).to eq(profile)
    end

   	it "render the show view" do
			get :show, {user_id: user.id}
    	expect(response).to render_template(:show)
   	end
  end

  describe "#edit" do

		let!(:user) { FactoryGirl.create(:user) }
		let!(:profile) { FactoryGirl.create(:profile, user: user) }

    it "shows the right profile" do
			get :show, {user_id: user.id}
      expect(assigns(:profile)).to eq(profile)
    end

   	it "render the show view" do
			get :show, {user_id: user.id}
    	expect(response).to render_template(:show)
   	end
  end

  describe "#update" do

		let!(:user) { FactoryGirl.create(:user) }
		let!(:profile) { FactoryGirl.create(:profile, user: user) }

		context "valid attributes" do
	    it "located the requested profile" do
				#To complete    
	    end
	  end
	end
end


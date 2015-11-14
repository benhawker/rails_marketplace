require 'rails_helper'

RSpec.describe ListingsController, type: :controller do
	describe "#show" do
		let(:user) { FactoryGirl.create(:user) }
	  let!(:category) { FactoryGirl.create(:category) }
	  let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }

    it "renders the show template" do
			get :show, {id: listing.id}
      expect(response).to render_template(:show)
      expect(response.status).to eql(200)
    end

    it "shows the correct listing" do
      get :show, {id: listing.id}
      expect(assigns(:listing)).to eq(listing)
    end
  end

  describe "#index" do
	  let!(:user) { FactoryGirl.create(:user) }
	  let!(:category) { FactoryGirl.create(:category) }
	  let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }
  
	  it "assigns all articles as @articles" do
    	get :index
    	assigns(:listings).should eq([listing])
	  end
	end
end



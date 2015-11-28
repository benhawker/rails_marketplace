require 'rails_helper'

RSpec.describe ListingsController, type: :controller do

  describe "#show" do
    let(:user) { FactoryGirl.create(:user) }
    let!(:category) { FactoryGirl.create(:category) }
    let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }

    before(:each) { login_as(user) }

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
    let(:user) { FactoryGirl.create(:user) }
    let!(:category) { FactoryGirl.create(:category) }
    let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }

    before(:each) { login_as(user) }

    it "assigns all listings as @listings" do
      get :index
      expect(assigns(:listings)).to eq([listing])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
      expect(response.status).to eql(200)
    end
  end

  describe "#new" do
    let(:user) { FactoryGirl.create(:user) }
    before(:each){ login_as(user) }  

    it "assigns a new listing as @listing" do
      get :new
      expect(assigns(:listing)).to be_a_new(Listing)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
      expect(response.status).to eql(200)
    end
  end

  describe "#edit" do
    let!(:user) { FactoryGirl.create(:user) }
    let!(:category) { FactoryGirl.create(:category) }
    let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }

    before(:each) { login_as(user) }

    it "assigns the requested listing as @listing" do
      get :edit, {:id => listing.to_param}
      expect(assigns(:listing)).to eq(listing)
    end
  end
end



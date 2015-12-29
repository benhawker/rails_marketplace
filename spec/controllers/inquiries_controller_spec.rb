require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
	
	let(:user) { FactoryGirl.create(:user) }
	let!(:category) { FactoryGirl.create(:category) }
  let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }

	describe "#index" do
    before(:each) { login_as(user) }

    it "assigns all inquiries as @inquiries" do
      get :index
      expect(assigns(:inquiries)).to eq([inquiry])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
      expect(response.status).to eql(200)
    end
  end

  describe "#new" do
    before(:each){ login_as(user) }  

    it "assigns a new inquiry as @inquiry" do
      get :new
      expect(assigns(:inquiry)).to be_a_new(Inquiry)
    end

    it "renders the new template" do
      get :new
      expect(response).to render_template(:new)
      expect(response.status).to eql(200)
    end
  end
end

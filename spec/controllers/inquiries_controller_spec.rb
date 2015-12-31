require 'rails_helper'

RSpec.describe InquiriesController, type: :controller do
	
	let(:user) { FactoryGirl.create(:user) }
  let(:user_two) { FactoryGirl.create(:user, :bill) }
	let!(:category) { FactoryGirl.create(:category) }
  let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user, category: category) }
  let!(:inquiry) { FactoryGirl.create(:inquiry, sender: user, recipient: user_two, listing: listing) }

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

    xit "assigns a new inquiry as @inquiry" do
      get :index #as this is dealt with on the index
      expect(assigns(:inquiry)).to be_a_new(Inquiry)
    end
  end
end

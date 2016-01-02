require 'rails_helper'

RSpec.describe FeedbacksController, type: :controller do

	let(:user_one) { FactoryGirl.create(:user) }
  let(:user_two) { FactoryGirl.create(:user, :bill) }
	let!(:category) { FactoryGirl.create(:category) }
  let!(:listing) { FactoryGirl.create(:listing, :les_paul, user: user_one, category: category) }
  let!(:inquiry) { FactoryGirl.create(:inquiry, sender: user_one, recipient: user_two, listing: listing) }
	let!(:feedback) { FactoryGirl.create(:feedback, seller: user_one, buyer: user_two, listing: listing) }
	
	describe "#index" do
    before(:each) { login_as(user_one) }

    it "assigns all feedbacks as @feedbacks" do
      get :index
      expect(assigns(:feedbacks)).to eq([feedback])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
      expect(response.status).to eql(200)
    end
  end

end

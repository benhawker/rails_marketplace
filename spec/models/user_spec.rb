require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:listings).dependent(:destroy) }
  it { should have_many(:watches).dependent(:destroy) }
  it { should have_many(:inquiries) }
  it { should have_many(:messages) }
  it { should have_many(:watched_listings).through(:watches).dependent(:destroy) }
  it { should have_many(:offers).dependent(:destroy) }
  it { should have_many(:given_feedbacks_as_seller) }
  it { should have_many(:given_feedbacks_as_buyer) }
  it { should have_many(:received_feedbacks_as_seller) }
  it { should have_many(:received_feedbacks_as_buyer) }

  let!(:user_one) { FactoryGirl.create(:user) }
  let!(:category) {FactoryGirl.create(:category) }
  let!(:listing_one) { FactoryGirl.create(:listing, user: user_one, category: category) }
  let!(:listing_two) { FactoryGirl.create(:listing, user:  user_one, category: category) }
  
  context 'watching a listing' do
    it 'counts the correct number of listings user is watching' do
      user_one.watched_listings << listing_one
      user_one.watched_listings << listing_two
      expect(user_one.watched_listings.count).to eq 2
    end
  end

  context "user role" do
    it 'user has a role of standard by default' do 
      expect(user_one.role).to eq ("standard")
    end

    it 'user is invalid if role is not found within User::ROLES' do
      user_one.role = "bob"
      expect(user_one).to_not be_valid
      expect(user_one.errors[:role]).to include "is not included in the list"
    end

    it 'user is invalid if role is blank' do
      user_one.role = nil
      expect(user_one).to_not be_valid
      expect(user_one.errors[:role]).to include "is not included in the list"
    end
  end

  context "with an invalid email address format" do
    it "should not be valid" do
      ["ben_ hawker@XYZ.com", "ben++hawker@gmail.com", "ben....hawker@gmail.com"].each do |format|
        user_one.email = format
        expect(user_one).to_not be_valid
      end
    end
  end

end

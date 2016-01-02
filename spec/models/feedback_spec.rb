require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should belong_to(:seller).class_name('User').with_foreign_key('seller_id') }
  it { should belong_to(:buyer).class_name('User').with_foreign_key('buyer_id') }

  it { should belong_to(:listing) }

  it { should validate_presence_of(:seller) }
  it { should validate_presence_of(:buyer) }
  it { should validate_presence_of(:listing) }

	it { should validate_uniqueness_of(:seller_id).scoped_to(:listing_id) }
	it { should validate_presence_of(:rating).with_message("Your feedback must have a rating") }
	it { should validate_presence_of(:comment).with_message("Your feedback must have a comment") }

	let!(:user_one) { FactoryGirl.create(:user, :ben) }
	let!(:user_two) { FactoryGirl.create(:user, :bob) }
	let!(:category) {FactoryGirl.create(:category) }
	let(:listing) { FactoryGirl.create(:listing, category: category, user: user_one) }
	let(:offer) { FactoryGirl.create(:offer, user: user_two, listing: listing) }
	let!(:feedback) { FactoryGirl.create(:feedback, seller: user_one, buyer: user_two, listing: listing) }


	context "valid Feedback" do
		it "feedback cannot be created without a seller, a buyer & a listing" do
	 		expect{ Feedback.create()}.not_to change{Feedback.count}
	  end

	 	it "will be created with a user, a listing & a price ALSO rating & comment" do
	 		expect{ Feedback.create(seller: user_two, buyer: user_one, listing: listing, rating: true, comment: "Great!") }.to change{Feedback.count}
	  end

	  it "user cannot leave feedback on their own item" do
	  	expect{ Feedback.create(seller: user_one, buyer: user_two, listing: listing, rating: true, comment: "Great!") }.to raise_error('You cannot leave feedback on your own listing.')
	  end
	end

	context "feedback direction" do
    it 'direction will be buyer_to_seller by default' do
      expect(feedback.direction).to eq ("buyer_to_seller")
    end

    it 'feedback is invalid if direction is not found within Feedback::VALID_DIRECTIONS' do
      feedback.direction = "North"
      expect(feedback).to_not be_valid
      expect(feedback.errors[:direction]).to include "is not included in the list"
    end

    it 'feedback is invalid if status is blank' do
      feedback.direction = nil
      expect(feedback).to_not be_valid
      expect(feedback.errors[:direction]).to include "is not included in the list"
    end
  end

	context "#positive & #negative" do
		it "return positive for positive feedback" do
			feedback.rating = true
			expect(feedback.positive?).to eq true
		end

		it "return negative for negative feedback" do
			feedback.rating = false
			expect(feedback.negative?).to eq true
		end
	end

end

require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
  it { should belong_to(:recipient).class_name('User').with_foreign_key('recipient_id') }
  it { should belong_to(:listing) }

  it { should validate_presence_of(:author) }
  it { should validate_presence_of(:recipient) }
  it { should validate_presence_of(:listing) }

	# it { should validate_presence_of(:rating).with_message("Your feedback must have a rating") }
	# it { should validate_presence_of(:comment).with_message("Your feedback must have a comment") }


	# let!(:user_one) { FactoryGirl.create(:user, :ben) }
	# let!(:user_two) { FactoryGirl.create(:user, :bob) }
	# let!(:category) {FactoryGirl.create(:category) }
	# let(:listing) { FactoryGirl.create(:listing, category: category, user: user_one) }
	# let(:offer) { FactoryGirl.create(:offer, user: user_two, listing: listing) }

	# context "valid Feedback" do
	# 	it "feedback cannot be created without a author, a recipient & a listing" do
	#  		expect{ Feedback.create() }.not_to change{Feedback.count}
	#   end

	#   let(:listing_two) { FactoryGirl.create(:listing, category: category, user: user_two) }

	#  	it "will be created with a user, a listing & a price ALSO rating & comment" do
	#  		expect{ Feedback.create(author: user_one, recipient: user_two, listing: listing_two, rating: true, comment: "Great!") }.to change{Feedback.count}
	#   end

	#   it "user cannot leave feedback as author on their own item" do
	#   	expect{ Feedback.create(author: user_one, recipient: user_two, listing: listing, rating: true, comment: "Great!") }.to raise_error('You cannot leave feedback on your own listing.')
	#   end
	# end

	# let(:feedback) { FactoryGirl.create(:feedback, author: user_two, recipient: user_one, listing: listing) }
end

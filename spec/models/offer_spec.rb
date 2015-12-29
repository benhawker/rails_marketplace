require 'rails_helper'

RSpec.describe Offer, type: :model do
  #Associations
  it { should belong_to(:listing) }
  it { should belong_to(:user) }

  #Association validations
  it { should validate_presence_of(:listing) }
  it { should validate_presence_of(:user) }

  #Attribute validations
  it { should validate_presence_of(:price).with_message("Your offer must have a price!") }

	let!(:user_one) { FactoryGirl.create(:user, :ben) }
	let!(:user_two) { FactoryGirl.create(:user, :bob) }
	let!(:category) {FactoryGirl.create(:category) }
	let(:listing) { FactoryGirl.create(:listing, category: category, user: user_one) }
	let(:offer) { FactoryGirl.create(:offer, user: user_two, listing: listing) }

  it "cannot be created without a user, a listing & a price" do
 		expect{ Offer.create(price: 4.99, listing: listing)}.not_to change{Offer.count}
  end

 	it "will be created with a user, a listing & a price" do
 		expect{ Offer.create(price: 4.99, user: user_one, listing: listing)}.to change{Offer.count}
  end

  context 'as a buyer' do
	  context 'making an offer' do
	    it 'is accepted if offer is valid price' do
	    	offer.price = 4.99
	    	expect(offer).to be_valid
	    end

	    it 'raises an error if offer is not a valid price' do
	    	offer.price = "bob"
	    	expect(offer).to_not be_valid
	    end

	    it 'user cannot make a new offer if they currently have an existing offer on the listing' do
				# expect{ Offer.build(price: 4.99, user: user_two, listing: listing)}.not_to change{Offer.count}
				expect{ FactoryGirl.create(:offer, user: user_two, listing: listing) }.to raise_error('You already have a live offer on this listintg.')
	    end

	    it 'raises an error if user has already made 5 offers on a listing' do
	    	5.times { FactoryGirl.create(:offer, user: user_two, listing: listing) }
	    	expect{ FactoryGirl.create(:offer, user: user_two, listing: listing) }.to raise_error('You have already made 5 offers on this listing.')
	    end

	    it 'raises an error if user has more than 15 live offers' do
	    	10.times { FactoryGirl.create(:offer, user: user_two, listing: listing) }
	    	#expect{ FactoryGirl.create(:offer, user: user_two, listing: listing) }.to raise_error('You cannot have more than 10 live offers at any one time.')
	    	expect{ Offer.create(price: 4.99, user: user_two, listing: listing) }.to raise_error('You cannot have more than 10 live offers at any one time.')
	    end
	  end
	  
	  context 'viewing your offers' do

  	end

  	context 'cancelling your offer' do
  		it 'buyer cannot cancel/delete their order within 24 hrs of making it' do
  			
  		end
  	end

  end

  context 'as a seller' do
  	context 'viewing your offers' do

  	end

  	context 'accepting offers' do

  	end

  	context 'declining offers' do

  	end
  end

end

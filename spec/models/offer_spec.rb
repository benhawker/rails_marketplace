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
	    end

	    it 'raises an error if user has already made 5 offers on a listing' do
	    	4.times do
	    		FactoryGirl.create(:offer, user: user_two, listing: listing)
	    	end
	    	expect{ FactoryGirl.create(:offer, user: user_two, listing: listing) }.
	    end

	    it 'raises an error if user has more than 15 live offers' do

	    end
	  end
	  
	  context 'viewing your offers' do

  	end

  	context 'cancelling your offer' do

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

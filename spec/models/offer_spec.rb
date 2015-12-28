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


  context 'as a buyer' do
	  context 'making an offer' do
	    let!(:user_one) { FactoryGirl.create(:user) }
	    let!(:user_two) { FactoryGirl.create(:user, :bob) }
	    let!(:category) {FactoryGirl.create(:category) }
	    let(:listing) { FactoryGirl.create(:listing, category: category, user: user_one) }

	    it 'an offer must be a valid price' do

	    end

	    it 'raises an error if offer is not a valid price' do

	    end

	    it 'user cannot make a new offer if they currently have an existing offer on the listing' do

	    end

	    it 'raises an error if user has already made 5 offers on a listing' do

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

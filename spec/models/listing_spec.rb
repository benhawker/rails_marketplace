require 'rails_helper'

RSpec.describe Listing, type: :model do

  #Associations
  it { should belong_to(:user) }
  it { should belong_to(:category) }
  it { should have_many(:photos) }
  it { should have_many(:watches) }
  it { should have_many(:watchers).through(:watches) }
  it { should have_many(:offers) }
  it { should belong_to(:location).dependent(:destroy) }

  #Association validations
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:user) }
  # it { should validate_presence_of(:photo).with_message("Please add a photo. Every listing minimum 1 photo.") }

  #Attribute validations
  it { should validate_presence_of(:title).with_message("Please add a title.") }
  it { should validate_presence_of(:subtitle).with_message("Please add a subtitle.") }
  it { should validate_presence_of(:price).with_message("Please add a price.") }
  it { should validate_presence_of(:condition).with_message("Please select a condition.") }

  let!(:user_one) { FactoryGirl.create(:user) }
  let!(:user_two) { FactoryGirl.create(:user, :bob) }
  let!(:category) {FactoryGirl.create(:category) }
  let(:listing) { FactoryGirl.create(:listing, category: category, user: user_one) }

  context "listing status changes" do
    it "changes status to hidden when hide! is called" do
      expect { listing.hide! }.to change(listing, :status).from('active').to('hidden')
    end

    it "changes status to completed when mark_complete! is called" do
      expect { listing.mark_complete! }.to change(listing, :status).from('active').to('completed')
    end
  end

  context 'watching a listing' do
    it 'a listing cannot be watched twice by the same user' do
      user_one.watched_listings << listing
      user_one.watched_listings << listing
      expect(user_one.watched_listings.count).to eq 1
      expect(listing.watchers.count).to eq 1
    end

    it 'counts the correct number of watchers per listing' do
      user_one.watched_listings << listing
      user_two.watched_listings << listing
      expect(listing.watchers.count).to eq 2
      expect(user_one.watched_listings.count).to eq 1
      expect(user_two.watched_listings.count).to eq 1
    end
  end
end

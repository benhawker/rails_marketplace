require 'rails_helper'

RSpec.describe Listing, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:watches) }
  it { should have_many(:watchers).through(:watches) }

  context 'watching a listing' do
    it 'a listing cannot be watched twice by the same user' do
      user = User.create(email: "ben@test.com", password: "password", password_confirmation: "password")
      listing = user.listings.create(title: "Stratocaster")
      user.watched_listings << listing
      user.watched_listings << listing
      expect(user.watched_listings.count).to eq 1
      expect(listing.watchers.count).to eq 1
    end

    it 'counts the correct number of watchers per listing' do
      user1 = User.create(email: "ben@test.com", password: "password", password_confirmation: "password")
      user2 = User.create(email: "bob@test.com", password: "password", password_confirmation: "password")
      listing = user1.listings.create(title: "Stratocaster")
      user1.watched_listings << listing
      user2.watched_listings << listing
      expect(listing.watchers.count).to eq 2
      expect(user1.watched_listings.count).to eq 1
    end
  end

end

require 'rails_helper'

RSpec.describe Listing, type: :model do

  #Associations
  it { should belong_to(:user) }
  it { should belong_to(:category) }
  it { should have_many(:photos) }
  it { should have_many(:watches) }
  it { should have_many(:watchers).through(:watches) }

  #Association validations
  it { should validate_presence_of(:category) }
  it { should validate_presence_of(:user) }
  it { should validate_presence_of(:photo).with_message("Please add a photo. Every listing minimum 1 photo.") }

  #Attribute validations
  it { should validate_presence_of(:title).with_message("Please add a title.") }
  it { should validate_presence_of(:subtitle).with_message("Please add a subtitle.") }
  it { should validate_presence_of(:price).with_message("Please add a price.") }
  it { should validate_presence_of(:title).with_message("Please select a condition.") }
  it { should validate_presence_of(:location).with_message("Please select a location.") }

  context 'watching a listing' do
    it 'a listing cannot be watched twice by the same user' do
      user = User.create(email: "ben@test.com", password: "password", password_confirmation: "password")
      category = Category.create
      listing = user.listings.create(title: "Stratocaster", category: category)
      user.watched_listings << listing
      user.watched_listings << listing
      expect(user.watched_listings.count).to eq 1
      expect(listing.watchers.count).to eq 1
    end

    it 'counts the correct number of watchers per listing' do
      user1 = User.create(email: "ben@test.com", password: "password", password_confirmation: "password")
      user2 = User.create(email: "bob@test.com", password: "password", password_confirmation: "password")
      category = Category.create
      listing = user1.listings.create(title: "Stratocaster", category: category)
      user1.watched_listings << listing
      user2.watched_listings << listing
      expect(listing.watchers.count).to eq 2
      expect(user1.watched_listings.count).to eq 1
    end
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_one(:profile) }
  it { should have_many(:listings) }
  it { should have_many(:watches) }
  it { should have_many(:watched_listings).through(:watches) }

  context 'watching a listing' do
    it 'counts the correct number of listings user is watching' do
      user1 = User.create(email: "ben@test.com", password: "password", password_confirmation: "password")
      user2 = User.create(email: "bob@test.com", password: "password", password_confirmation: "password")
      category = Category.create
      listing1 = user1.listings.create(title: "Strat", category: category)
      listing2 = user1.listings.create(title: "LP", category: category)
      user2.watched_listings << listing1
      user2.watched_listings << listing2
      expect(user2.watched_listings.count).to eq 2
    end
  end
end

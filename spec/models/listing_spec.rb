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
    end
  end

end

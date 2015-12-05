require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:listings) }
  it { should have_many(:watches) }
  it { should have_many(:inquiries) }
  it { should have_many(:messages) }
  it { should have_many(:watched_listings).through(:watches) }

  context 'watching a listing' do
    let!(:user_one) { FactoryGirl.create(:user) }
    let!(:category) {FactoryGirl.create(:category) }
    let!(:listing_one) { FactoryGirl.create(:listing, user: user_one, category: category) }
    let!(:listing_two) { FactoryGirl.create(:listing, user:  user_one, category: category) }

    it 'counts the correct number of listings user is watching' do
      user_one.watched_listings << listing_one
      user_one.watched_listings << listing_two
      expect(user_one.watched_listings.count).to eq 2
    end
  end
end

require 'rails_helper'

describe SuggestedListings do

  before do
    @listing = FactoryGirl.create(:host)
    @user = FactorlGirl.create(:user)
  end

  it "suggests active listings of relevance linked to the listing being viewed" do
    listing = FactoryGirl.create(:listing)
    alternate_listing = FactoryGirl.create(:listing, user: user, destination: room.category)

    expect(SuggestedListings.suggest_relevant_listings(listing)).to include(alternate_listing)
  end

end

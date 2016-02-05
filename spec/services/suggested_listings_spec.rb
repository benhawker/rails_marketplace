require 'rails_helper'

describe SuggestedListings do

	let(:category) { FactoryGirl.create(:category) }
  let(:user) { FactoryGirl.create(:user) }
  let(:listing) { FactoryGirl.create(:listing, user: user, category: category) }

	let(:user) { FactoryGirl.create(:user, :ben) }
  let(:alternate_listing) { FactoryGirl.create(:listing, user: user, category: category) }

  it "suggests active listings of relevance linked to the listing being viewed" do
    expect(SuggestedListings.suggest_relevant_listings(listing)).to include(alternate_listing)
  end

end

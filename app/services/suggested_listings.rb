class SuggestedListings

  def self.suggest_relevant_listings(listing)
  	listing.category.listings.active
  end

end

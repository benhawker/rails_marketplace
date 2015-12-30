class ListingPresenter
  attr_reader :listing

  def initialize(listing, current_user = nil)
    @listing = listing
    @current_user = current_user
  end

  def title(options = {})
    @room.title.capitalize
  end

  def share_url
    request.fullpath
  end
end
class OffersController < ApplicationController

  def index
    #@user = User.find(params[:id])
    @listing = Listing.find(params[:listing_id])
    @offers = @listing.offers.all
    authorize! :read, @listing
  end

	def new
    @listing = Listing.find(params[:listing_id])
    @offer = Offer.new
  end

  def show
    @listing = Listing.find(params[:listing_id])
    @offer = @listing.offers.find(params[:id])
  end

  def create
    @listing = Listing.find(params[:listing_id])
    @offer = @listing.build_offer(offer_params, current_user)

    if @offer.save
    	flash[:notices] = ["Offer successfully submitted to seller"]
      redirect_to listing_path(@listing)
    else
			render 'new'
    end
  end

  def destroy    
    @listing = Listing.find(params[:listing_id])
    @offer = @listing.offers.find(params[:id])
    
    if @offer.destroy
      flash[:notice] = 'Offer deleted successfully'
      redirect_to user_offers_path(current_user)
    else
      flash[:notice] = 'We were unable to delete your offer'
    end
  end

  private

 	def offer_params
    params.require(:offer).permit(:price)
  end


end


class OffersController < ApplicationController
	
	def new
    @listing = Listing.find(params[:listing_id])
    @offer = Offer.new
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

  private

 	def offer_params
    params.require(:offer).permit(:price)
  end


end


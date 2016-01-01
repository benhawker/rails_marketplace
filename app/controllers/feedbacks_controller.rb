class FeedbacksController < ApplicationController
  before_filter :get_listing
  before_filter :can_only_post_feedback_once, :only => [:create]

  def show

  end

  def create

  end

	private
	
  def feedback_params
    params.require(:feedback).permit(:rating, :comment)
  end

  def get_listing
    @listing = current_user.listings.find(params[:listing_id])
  end

  def can_only_post_feedback_once
    if @listing.feedbacks.buyer_to_seller.first
      redirect_to root_path
    end
  end

end

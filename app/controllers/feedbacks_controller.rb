class FeedbacksController < ApplicationController
  before_filter :can_only_post_feedback_once, :only => [:create]

  def index
    @user = User.find(params[:user_id])
    # @feedbacks = @user.feedbacks.all
    @feedbacks = @user.all_feedbacks
  end


	private

  def feedback_params
    params.require(:feedback).permit(:rating, :comment)
  end

  def can_only_post_feedback_once
    if @listing.feedbacks.buyer_to_seller.first
      redirect_to root_path
    end
  end

end

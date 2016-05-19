class FeedbacksController < ApplicationController
  # before_filter :can_only_post_feedback_once, :only => [:create]

  def index
    @user = User.find(params[:user_id])
    @feedbacks = @user.all_feedbacks
  end

  def show

  end

  def new
    @author = current_user
    @listing = Listing.find(params[:listing_id])
    @recipient = @listing.user
    @feedback = Feedback.new
    
    @feedback_presenter = FeedbackPresenter.new(@listing)
  end

  def create
    @author = current_user
    @listing = Listing.find(params[:listing_id])
    @recipient = @listing.user

    @feedback = @author.authored_feedbacks.build(listing_id: @listing.id, author_id: @author.id, recipient_id: @recipient.id, rating: params[:feedback][:rating], comment: params[:feedback][:comment])
    if @feedback.save
      flash[:notices] = ["Feedback successfully submitted"]
      redirect_to user_feedbacks_path(@user)
    else
      render 'new'
    end
  end

	private

  def feedback_params
    params.require(:feedback).permit!
    # params.require(:feedback).permit(:rating, :comment)
  end

  # def can_only_post_feedback_once
  #   if @listing.feedbacks.buyer_to_seller.first
  #     redirect_to root_path
  #   end
  # end

end

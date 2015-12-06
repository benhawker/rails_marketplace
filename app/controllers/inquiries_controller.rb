class InquiriesController < ApplicationController

# before_action :authenticate_user
	
def index
	@users = User.all
	@inquiries = Inquiry.all
end

def new
	@sender = User.find_by(id: params[:sender])
	@recipient = User.find_by(id: params[:recipient])
  @listing = Listing.find_by(id: params[:listing])
	
	@inquiry = current_user.inquiries.new
  @message = @inquiry.messages.build
end

def create
	@sender = User.find_by(id: params[:sender_id])
	@recipient = User.find_by(id: params[:recipient_id])
  @listing = Listing.find_by(id: params[:listing_id])

  #need to add separation to create new inquiry when it's a different listing.
	if Inquiry.between(@sender,@recipient).present?
		@inquiry = Inquiry.between(@sender, @recipient).first
  else
  	@inquiry = Inquiry.create!(inquiry_params)
  	@inquiry.listing << Listing.find_by(id: params[:listing_id])
  end
  	redirect_to inquiry_messages_path(@inquiry)
end

private
	def inquiry_params
		params.permit(:sender_id, :recipient_id, :listing_id)
  end

end
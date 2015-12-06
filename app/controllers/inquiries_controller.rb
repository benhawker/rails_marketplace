class InquiriesController < ApplicationController

# before_action :authenticate_user
	
def index
	@users = User.all
	@inquiries = Inquiry.all
end

def new
	@sender = User.find_by(id: params[:sender_id])
	@recipient = User.find_by(id: params[:recipient_id])
  @listing = Listing.find_by(id: params[:listing])
	
	@inquiry = current_user.inquiries.new
  @message = @inquiry.messages.build
end

def create
	if Inquiry.between(params[:sender_id],params[:recipient_id]).present?
  	@inquiry = Inquiry.between(params[:sender_id], params[:recipient_id]).first
  else
  	@inquiry = Inquiry.create!(inquiry_params)
  end

 	redirect_to inquiry_messages_path(@inquiry)
end

private
	def inquiry_params
		params.permit(:sender_id, :recipient_id)
  end

end

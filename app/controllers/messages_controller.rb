class MessagesController < ApplicationController
	before_action do
		@inquiry = Inquiry.find(params[:inquiry_id])
  end

	def index
		@messages = @inquiry.messages
	  if @messages.length > 10
	  	@over_ten = true
	  	@messages = @messages[-10..-1]
	  end
	  
	  if params[:m]
	  	@over_ten = false
	  	@messages = @inquiry.messages
	  end
	 
	 	if @messages.last
	  	if @messages.last.user_id != current_user.id
	  		@messages.last.read = true;
	  	end
	 	end

 		@message = @inquiry.messages.new
 	end

	def new
	 @message = @inquiry.messages.new
	end
	
	def create
	 @message = @inquiry.messages.new(message_params)
	 if @message.save
	  redirect_to inquiry_messages_path(@inquiry)
	 end
	end
	
	private
	
	def message_params
	  params.require(:message).permit(:body, :user_id)
	end
end
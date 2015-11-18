class MessagesController < ApplicationController
  before_action :authenticate_user!

  # def new
  #   @user = User.find_by(id: params[:user])
  # end

  # def create
  #   recipients = User.where(id: params['recipients'])
  #   conversation = current_user.send_message(recipients, params[:message][:body], params[:message][:subject]).conversation
  #   flash[:success] = "Message has been sent!"
  #   redirect_to conversation_path(conversation)
  # end

  def new
    @user = User.find_by(id: params[:user])
    @message = current_user.messages.new
    @listing = Listing.find_by(id: params[:listing])
  end

  def create
    @recipient = User.find_by(id: params[:user])
    # @conversation = current_user.send_message(@recipient, params[:body], params[:subject]).conversation
    conversation = current_user.send_message(@recipient, "Hello", "Subject").conversation
    flash[:notices] = ["Your message was successfully sent to the seller"]
    redirect_to root_path
     # redirect_to conversation_path(@conversation)
  end
end
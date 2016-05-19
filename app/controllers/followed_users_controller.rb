class FollowedUsersController < ApplicationController

  def index
    @user = User.find(params[:user_id] || params[:id])
    @followed_users = @user.followed_users
  end

  # def new
  #   @user = User.find(params[:user_id] || params[:id])
  # end

end

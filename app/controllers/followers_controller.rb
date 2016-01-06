class FollowersController < ApplicationController

  # def create
 #    @user = User.find(params[:user_id] || params[:id])
 #    @user.followers << @current_user
 #  end

  def create
    @user = User.find(params[:user_id] || params[:id])
    
    if @user.followers << @current_user
      flash[:notices] = ["You are now following #{user.email}"]
    end
  end
end

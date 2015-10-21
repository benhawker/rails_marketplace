class UsersController < ApplicationController
	def index
		@users = User.all
		if params[:search]
    	@users = User.search(params[:search]).order("created_at DESC")
  	else
    	@users = User.all.order('created_at DESC')
  	end
	end

	def show
		@user = User.find(params[:id])
	end

	def watchlist
		# @user = User.find(current_user)
		# @user = User.find(params[:user_id])
		# @user = current_user
		@watched_listings = current_user.watched_listings.all
	end

end

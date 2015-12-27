class UsersController < ApplicationController
  load_and_authorize_resource
  # before_filter :authenticate_user!, :only [:edit, :update]

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

  def edit

    @user = User.find(params[:id])
    # authorize! :read, @user, :message => "You cannot edit another user's profile"
    # # authorize! :all, @user, :message => "You cannot edit another user's profile"
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notices] = ["Your profile was successfully updated"]
      render 'show'
    else
      flash[:notices] = ["Your profile could not be updated"]
      render 'edit'
    end
  end

  def watchlist
    @watched_listings = current_user.watched_listings.all
  end

  def offers
    @offers = current_user.offers.all
  end

  private

  def user_params
    params.require(:user).permit(:city, :country, :avatar, :role)
  end

end
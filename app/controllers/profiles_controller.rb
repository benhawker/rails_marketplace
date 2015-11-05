class ProfilesController < ApplicationController

  before_filter :authenticate_user!, :only => [:edit, :update]

	def show
		# @profile = Profile.find_by user_id: current_user.id
     @profile = Profile.find_by(user_id: params[:user_id])
	end

	def edit
    @profile = Profile.find_by user_id: current_user.id
	end

	def update
	  @profile = Profile.find_by user_id: current_user.id
    if @profile.update(profile_params)
      flash[:notices] = ["Your profile was successfully updated"]
      render 'show'
    else
      flash[:notices] = ["Your profile could not be updated"]
      render 'edit'
    end
  end

  def profile_params
    params.require(:profile).permit(:city, :country, :avatar)
  end
end


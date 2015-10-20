class ListingsController < ApplicationController

	before_filter :authenticate_user!, :only => [:new, :create, :edit, :update]
	# before_filter :must_be_listing_owner, :only => [:edit, :update]

	def index
		@listings = Listing.all
		if params[:search]
    	@listings = Listing.search(params[:search]).order("created_at DESC")
  	else
    	@listings = Listing.all.order('created_at DESC')
  	end
	end

	def new
		@listing = Listing.new
	end

	def create
		@user = current_user
		@listing = @user.listings.build(listing_params)
    if @listing.save
    	flash[:notices] = ['Listing created successfully']
    	redirect_to listings_path
    else
    	render 'new'
    end
	end

	def show
		@listing = Listing.find(params[:id])
	end

	def edit
		@user = current_user
		@listing = @user.listings.find(params[:id])
	end

  def update
    @user = current_user
    @listing = @user.listings.find(params[:id])
    if @listing.update(listing_params)
      flash[:notices] = ["Your listing was successfully updated"]
      render 'show'
    else
      flash[:notices] = ["Your listing could not be updated"]
      render 'edit'
    end
  end

  def destroy
		@user = current_user
		@listing = @user.listings.find(params[:id])
    if @listing.destroy
      flash[:notices] = ['Your listing was successfully deleted']
      redirect_to '/listings'
    else
      flash[:alerts] = ['Sorry something went wrong. Your listing was not deleted.']
      redirect_to '/edit'
    end
  end

	def listing_params
    params.require(:listing).permit(:title, :subtitle, :description)
  end

  # private

  # def must_be_listing_owner
  #   head :forbidden unless @listing.user.id == current_user.id
  # end

end

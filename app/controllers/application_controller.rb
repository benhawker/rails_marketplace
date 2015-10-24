class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound do
	  flash[:warning] = 'Resource not found.'
	  redirect_back_or root_path
	end

	def redirect_back_or(path)
	  redirect_to request.referer || path
	end

	def after_sign_in_path_for(resource)
    user_profile_path(resource)
  end

  def after_sign_up_path_for(resource)
    user_profile_path(resource)
  end

end

require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

		controller(ApplicationController) do
    	def index
      	render :nothing => true
    	end
  	end

end

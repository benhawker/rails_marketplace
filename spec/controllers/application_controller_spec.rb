require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

	it "raises RecordNotFound when not found" do
		# get :show, :id => 999
  #   assert_raises(ActiveRecord::RecordNotFound) do
  #     get :show, :id => 1234
  #   end

    # expect { get :show, id: 999	}.to raise_error(ActiveRecord::RecordNotFound)

    # get :show, :id => 245352
    # response.response_code.should == 404

    get :show, :id => 245352
    expect(response).to have_http_status(:not_found)
  end

end

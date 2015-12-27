require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  describe "#index" do
    it "renders the index/root page" do
      get :index
      expect(response).to render_template(:index)
      expect(response.status).to eql(200)
    end
  end
end
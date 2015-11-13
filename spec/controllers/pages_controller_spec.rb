require 'rails_helper'

RSpec.describe PagesController, type: :controller do
  describe "#about" do
    it "renders the about page" do
			get :about
      expect(response).to render_template(:about)
      expect(response.status).to eql(200)
    end
  end

  describe "#contact" do
    it "renders the contact page" do
			get :contact
      expect(response).to render_template(:contact)
      expect(response.status).to eql(200)
    end
  end

  describe "#faq" do
    it "renders the faq page" do
			get :faq
      expect(response).to render_template(:faq)
      expect(response.status).to eql(200)
    end
  end
end


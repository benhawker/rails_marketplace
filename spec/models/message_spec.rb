require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:inquiry) }

  it { should validate_presence_of(:body) }

  it "cannot be created without an inquiry, a user & a body of text" do
 		expect{ Message.create }.not_to change{ Offer.count }
  end

end

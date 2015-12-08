require 'rails_helper'

RSpec.describe Offer, type: :model do
  #Associations
  it { should belong_to(:listing) }
  it { should belong_to(:user) }

  #Association validations
  it { should validate_presence_of(:listing) }
  it { should validate_presence_of(:user) }

  #Attribute validations
  it { should validate_presence_of(:price).with_message("Your offer must have a price!") }
end

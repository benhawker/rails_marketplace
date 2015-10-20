require 'rails_helper'

RSpec.describe Listing, type: :model do
  it { should belong_to(:user) }
  it { should have_many(:watches) }
  it { should have_many(:watchers).through(:watches) }
end

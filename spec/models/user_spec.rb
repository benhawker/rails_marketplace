require 'rails_helper'

RSpec.describe User, type: :model do
  it { should have_many(:listings) }
  it { should have_many(:watches) }
  it { should have_many(:watched_listings).through(:watches) }
end

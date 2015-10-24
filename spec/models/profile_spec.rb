require 'rails_helper'

RSpec.describe Profile, type: :model do
  it { should belong_to(:user) }
end

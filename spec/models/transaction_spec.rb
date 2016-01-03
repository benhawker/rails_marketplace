require 'rails_helper'

RSpec.describe Transaction, type: :model do
	it { should belong_to(:listing) }
  it { should have_many(:feedbacks).dependent(:destroy) }
end

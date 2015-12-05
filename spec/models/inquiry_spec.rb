require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  it { should  belong_to(:user) }
  it { should belong_to(:listing) }
end

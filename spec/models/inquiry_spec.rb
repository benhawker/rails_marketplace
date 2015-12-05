require 'rails_helper'

RSpec.describe Inquiry, type: :model do
  it { should belong_to(:sender).class_name('User').with_foreign_key('sender_id') }
  it { should belong_to(:recipient).class_name('User').with_foreign_key('recipient_id') }

  it { should belong_to(:listing) }
end

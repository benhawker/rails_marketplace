require 'rails_helper'

RSpec.describe Message, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:inquiry) }
  it { should belong_to(:sent_user).class_name('User').with_foreign_key('sent_user_id') }
end

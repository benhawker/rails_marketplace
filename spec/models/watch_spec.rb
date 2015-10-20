require 'rails_helper'

RSpec.describe Watch, type: :model do
  it { should belong_to(:watcher).class_name('User') }
  it { should belong_to(:watched_listing).class_name('Listing') }
end

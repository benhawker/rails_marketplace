FactoryGirl.define do
  factory :inquiry do
    association :sender, factory: :user
  	association :recipient, factory: :user
  	association :listing
  end

end

FactoryGirl.define do
  factory :offer do
  	price 5.99
  	status "made"
    association :listing
    association :user
  end
end

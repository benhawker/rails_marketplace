FactoryGirl.define do
  factory :offer do
  	price 5.99
    association :listing
    association :user
  end
end

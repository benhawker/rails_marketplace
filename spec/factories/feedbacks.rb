FactoryGirl.define do
  factory :feedback do
    association :buyer, factory: :user
    association :seller, factory: :user
    association :listing
    rating { true }
    comment { Faker::Lorem.sentence }
  end

  trait :positive do
  	rating { true }
  end

  trait :negative do
  	rating { false }
  end

end

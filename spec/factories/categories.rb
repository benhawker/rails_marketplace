FactoryGirl.define do
  factory :category do
    name  { "Guitars" }
  end

  trait :bass do
  	name { "Bass" }
  end

  trait :acoustic do
  	name { "Acoustic" }
  end
end
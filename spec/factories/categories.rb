FactoryGirl.define do
  factory :category do
    category_name { "Guitars" }
    name  { "Guitars" }
  end

  trait :bass do
  	category_name { "Bass" }
  end

  trait :acoustic do
  	category_name { "Acoustic" }
  end
end
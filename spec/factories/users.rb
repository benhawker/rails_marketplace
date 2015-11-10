FactoryGirl.define do

	# sequence :email do |n|
 #    "email#{n}@factory.com"
 #  end
  
  factory :user do
		first_name "Ben"
    last_name "Hawker"
    user_name "benhawker"
    password "password"
    password_confirmation "password"
    email "ben@test.com"
  end

  trait :bob do
  	email "bob@test.com"
  end

  trait :bill do
  	email "bill@test.com"
  end
end


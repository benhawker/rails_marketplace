FactoryGirl.define do

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

  sequence(:first_name) { |n|  "Person #{n}"}
  sequence(:email) { |n| "person#{n}@example.com" }
end

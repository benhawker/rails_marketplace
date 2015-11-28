FactoryGirl.define do

  factory :user do
		first_name "Ben"
    last_name "Hawker"
    user_name "benhawker"
    password "password"
    password_confirmation "password"
    email "ben@test.com"
    after(:create) do |user|
      FactoryGirl.create(:profile, user: user)
    end
  end

  trait :bob do
  	email "bob@test.com"
  end

  trait :bill do
  	email "bill@test.com"
  end

  after

  sequence(:first_name) { |n|  "Person #{n}"}
  sequence(:email) { |n| "person#{n}@example.com" }
end

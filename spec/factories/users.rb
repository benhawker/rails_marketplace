FactoryGirl.define do
  factory :user do
		first_name "Ben"
    last_name "Hawker"
    user_name { "#{first_name}#{last_name}".downcase }
    password 'password'
    password_confirmation 'password'
    email { "#{first_name}@test.com".downcase }
  end

  trait :bob do
  	email "bob@test.com"
  end

  trait :bill do
  	email "bill@test.com"
  end
end


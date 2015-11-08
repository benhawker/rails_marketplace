FactoryGirl.define do
  factory :user do
		first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    user_name { "#{first_name}#{last_name}".downcase }
    password 'factorypassword'
    password_confirmation 'factorypassword'
    email { "#{first_name}.#{last_name}@example.com".downcase }
  end
end
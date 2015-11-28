FactoryGirl.define do
  factory :profile do
    #Associations
    association :user

    #Attributes
    city { Faker::Address.city }
    country { Faker::Address.country }

    avatar_file_name { 'test.jpg' }
    avatar_content_type { 'image/jpeg' }
    avatar_file_size { 305610 }
  end

end

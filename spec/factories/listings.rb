FactoryGirl.define do
  factory :listing do
  	#Associations
		user
		category
		# photo

  	#Attributes
    title { Faker::Lorem.sentence }
    subtitle { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price }
    condition { "New" }
    brand { Faker::Company.name }
    model { Faker::Commerce.product_name }
    case_type { "No Case" }
    location { Faker::Address.city }
  end
    
    # after(:build) do |listing|
    #   listing.category ||=  FactoryGirl.create(:category)
    #   listing.user ||= FactoryGirl.create(:user)
    #   listing.photos ||= FactoryGirl.create(:photo)
    # end

    trait :les_paul do
    	title "1959 Les Paul"
    	subtitle "A true gem with OHSC"
    	description "Test description"
    end

    trait :strat do
    	title "1970 CBS Strat"
    	subtitle "Olympic White"
    	description "Test description"
    end

    trait :takamine do
    	title "Takamine"
    	subtitle "MIJ"
    	description "Test description"
    end
end


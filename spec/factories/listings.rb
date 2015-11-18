FactoryGirl.define do
  factory :listing do
    #Associations
        # association :user, email: "somethingelse@gmail.com"
        # category
        # watch

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

    factory :listing_with_watch do
        after(:create) do |listing|
        create(:listing, watch: watch)
        end
    end
  end

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


FactoryGirl.define do

	 create_table "listings", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "title"
    t.string   "subtitle"
    t.string   "description"
    t.float    "price"
    t.string   "condition"
    t.string   "brand"
    t.string   "model"
    t.string   "case_type"
    t.string   "location"
    t.integer  "user_id"
    t.integer  "category_id"
  end
  factory :listing do
    title { Faker::Lorem.sentence }
    subtitle { Faker::Lorem.sentence }
    description { Faker::Lorem.sentence }
    price { Faker::Commerce.price }
    # condition { I18n.t(:"countries").keys.sample.to_s }
    brand { Faker::Company.name }
    model { Faker::Commerce.product }
    # case_type {  }
    location { Faker::Address.city }
    

    after(:build) do |room|
      WebMock.stub_request(:any, /maps.googleapis.com\/maps\/geo\?/).to_return do |request|
        File.new(Rails.root.join("spec", "support", "fixtures", "geocodes", "default.geostub"))
      end
      WebMock.stub_request(:any, /maps.googleapis.com\/maps\/api\/geocode\/json\?/).to_return do |request|
        File.new(Rails.root.join("spec", "support", "fixtures", "geocodes", "default.json.geostub"))
      end
      room.destination ||= Destination.with_globalize(name: room.city || Faker::Address.city).first || FactoryGirl.create(:destination, :city, name: room.city || Faker::Address.city)
      room.room_type ||= RoomType.where(type: 'apartment').first_or_create
      room.user ||= FactoryGirl.create :user, activated_at: Date.today - 1, validated_host: true, certified: false, payment_country: 'US'
    end
    after(:stub) do |room|
      #WebMock.stub_request(:any, /maps.googleapis.com\/maps\/geo\?/).to_return do |request|
      #  File.new(Rails.root.join("spec", "support", "fixtures", "geocodes", "default.geostub"))
      #end
      #WebMock.stub_request(:any, /maps.googleapis.com\/maps\/api\/geocode\/json\?/).to_return do |request|
      #  File.new(Rails.root.join("spec", "support", "fixtures", "geocodes", "default.json.geostub"))
      #end
      room.destination ||= build_stubbed(:destination, :city, name: room.city, url_name: room.city.try(:urlize, convert_space: "-"), url_path: room.city.try(:urlize, convert_space: "-"))
      room.city_destination ||= room.destination if room.destination.city?
      room.room_type ||= build_stubbed(:room_type, type: 'apartment')
      room.type = 'apartment'
      room.currency ||= build_stubbed(:currency)
      room.user ||= build_stubbed(:host, activated_at: Date.today - 1, validated_host: true, certified: false, payment_country: 'US')
    end

    trait :with_hardcase do
      after(:build) do |listing|
        listing.case_type = "Original HardCase"
        unit.tv = false
        unit.airconditioning = false
        unit.kitchen = false
      end
    end

    trait :without_amenities do
      after(:build) do |unit|
        unit.internet = false
        unit.tv = false
        unit.airconditioning = false
        unit.kitchen = false
        unit.laundry = false
        unit.free_cleaning = false
        unit.wheelchairaccess = false
        unit.pool = false
        unit.gym = false
        unit.cabletv = false
        unit.breakfast = false
        unit.elevator = false
        unit.doorman = false
        unit.bed_linen_and_towels = false
        unit.balcony = false
        unit.outdoor_space = false
        unit.wifi = false
        unit.parking = false
      end
    end

    trait :with_amenities do
      after(:build) do |unit|
        unit.internet = true
        unit.tv = true
        unit.airconditioning = true
        unit.kitchen = true
        unit.laundry = true
        unit.free_cleaning = true
        unit.wheelchairaccess = true
        unit.pool = true
        unit.gym = true
        unit.cabletv = true
        unit.breakfast = true
        unit.elevator = true
        unit.doorman = true
        unit.bed_linen_and_towels = true
        unit.balcony = true
        unit.outdoor_space = true
        unit.wifi = true
        unit.parking = true
      end
    end

    trait :with_conditions do
      smokingallowed true
      petsallowed true
    end

    trait :without_conditions do
      smokingallowed false
      petsallowed false
    end

    trait :with_picture do
      after(:build) do |room|
        # Create a room image
        room.images << FactoryGirl.build(:image)
      end
      after(:create) do |room|
        # Clear the images attached in after(:build) and create one without saving room again
        room.images.each do |image|
          image.room_id = room.id
          image.save
        end
        room.reload
      end
    end

    trait :visible_without_picture do
      without_picture
      disabled false
    end

    trait :without_picture do
      after(:build) do |room|
        # Create a room image
        room.images << []
      end
      after(:create) do |room|
        # Clear the images attached in after(:build) and create one without saving room again
        room.images.each do |image|
          image.destroy!
        end
        room.reload
      end
    end

    trait :visible do
      with_picture
      disabled false
    end

    trait :disabled do
      disabled true
    end

    trait :multi_unit do
      multi_unit true
    end

    trait :with_unit do
      multi_unit true
      after(:create) do |room|
        room.units << create(:unit, :visible, room: room)
        room.save
      end
      after(:stub) do |room|
        allow(room).to receive(:units).and_return([build_stubbed(:unit, :visible, room: room)]) if self.respond_to?(:allow)
      end
    end

    trait :with_subtype do
      after(:build) do |room|
        room.room_subtype ||= room.room_type.room_subtypes.where(type: 'bungalow').first_or_create
      end
      after(:stub) do |room|
        room.room_subtype ||= build_stubbed(:room_subtype, type: 'bungalow', room_type: room.room_type)
        room.subtype = 'bungalow'
      end
    end

    trait :bookable do
      visible
      default_available
      minimum_stay { 1 }
      max_guests { 20 }
    end

    trait :atleisure do
      source 'atleisure'
      sequence(:source_id) {|n| "XX-%04d" % n }
    end

    trait :kigo do
      source 'kigo'
      sequence(:source_id) {|n| "%d" % n }
    end

    trait :ciirus do
      source 'ciirus'
      sequence(:source_id) {|n| "%d" % n }
    end

    trait :resonline do
      source 'resonline'
      sequence(:source_id) {|n| "%d" % n}
    end

    trait :test_ciirus do
      source 'ciirus'
      source_id '33674'
    end

    trait :test_resonline do
      source 'resonline'
      source_id '279591'
    end

    trait :poplidays do
      source 'poplidays'
      sequence(:source_id) {|n| "%d" % n }
    end

    trait :api do
      source 'api'
    end

    trait :instantly_bookable do
      instant_booking true
      bookable
    end


    trait :wizard_step_1 do
      minimum_stay nil
      room_type_id { create(:room_type).id }
      city { create(:destination).name }
      default_available true
      deposit nil
      deposit_type nil
      surface_unit nil
    end

    trait :saturday_only do
      default_available false
      default_can_checkin false
      default_can_checkout false
      after(:create) do |room|
        room.recurring_availabilities << create(:recurring_availability, status: 0, can_checkin: true, can_checkout: true, day: 6)
      end
    end

    factory :room_with_picture, traits: [:with_picture]
  end
end
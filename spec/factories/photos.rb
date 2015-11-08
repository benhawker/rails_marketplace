FactoryGirl.define do
  factory :photo do
    image_file_name { 'test.jpg' }
    image_content_type { 'image/jpeg' }
    image_file_size { 305610 }
  end
end

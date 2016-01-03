class Photo < ActiveRecord::Base
  belongs_to :listing

  has_attached_file :image, :styles => { :medium => "200x200", :thumb => "100x100" }, :default_url => "default.jpg" 
  
  validates_attachment :image, :content_type => { :content_type => %w(image/jpeg image/jpg image/png) } 
  validates_attachment_size :image, :less_than => 9.megabytes

end

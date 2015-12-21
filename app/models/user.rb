class User < ActiveRecord::Base
  has_many :listings, dependent: :destroy
  has_many :watches, dependent: :destroy
  has_many :watched_listings,  -> { uniq }, :through => :watches, dependent: :destroy
  has_many :inquiries
  has_many :messages
  has_many :offers, dependent: :destroy

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ROLES = %i[admin standard]

  def self.search(search)
    where("email ILIKE ?", "%#{search}%") 
  end



  # after_create :send_welcome_mail
  
  # def send_welcome_mail
  #   UserMailer.sign_up_email(self).deliver
  # end

end

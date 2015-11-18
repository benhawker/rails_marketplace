class User < ActiveRecord::Base
  has_one :profile, dependent: :destroy
  has_many :listings, dependent: :destroy
  has_many :watches, dependent: :destroy
  has_many :watched_listings,  -> { uniq }, :through => :watches, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  acts_as_messageable

  def mailboxer_email(object)
    email
  end

  def self.search(search)
    where("email ILIKE ?", "%#{search}%") 
  end


  # def build_profile
  #   Profile.create(user: self)
  # end

  after_create :build_profile

  # after_create :send_welcome_mail
  
  # def send_welcome_mail
  #   UserMailer.sign_up_email(self).deliver
  # end

end

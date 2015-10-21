class User < ActiveRecord::Base

	has_many :listings
	has_many :watches
	has_many :watched_listings,  -> { uniq }, :through => :watches
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

end

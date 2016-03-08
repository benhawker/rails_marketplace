class User < ActiveRecord::Base

  ALLOWED_ROLES = %w(standard admin)

  has_many :listings, dependent: :destroy
  has_many :watches, dependent: :destroy
  has_many :watched_listings,  -> { uniq }, :through => :watches, dependent: :destroy
  has_many :inquiries
  has_many :messages
  has_many :offers, dependent: :destroy
  belongs_to :location, :dependent => :destroy

  #New proposed solution to Feedback relationship
  # has_many :authored_feedbacks, :class_name => "Feedback", :foreign_key => "author_id", :dependent => :destroy
  # has_many :received_feedbacks, -> { order("id DESC")}, :class_name => "Feedback", :foreign_key => "recipient_id", :dependent => :destroy
  # has_many :received_positive_feedbacks, -> { where(rating: true).order("id DESC") }, :class_name => "Feedback", :foreign_key => "recipient_id"
  # has_many :received_negative_feedbacks, -> { where(rating: false).order("id DESC") }, :class_name => "Feedback", :foreign_key => "recipient_id"

  # Feedbacks given - these associations to be removed.
  has_many :given_feedbacks_as_seller,
    -> { where(direction: 'seller_to_buyer') },
    class_name: 'Feedback',
    foreign_key: :seller_id
  has_many :given_feedbacks_as_buyer,
      -> { where(direction: 'buyer_to_seller') },
    class_name: 'Feedback',
    foreign_key: :buyer_id

  # Feedbacks receieved
  has_many :received_feedbacks_as_seller,
    -> { where(direction: 'seller_to_buyer') },
    class_name: 'Feedback',
    foreign_key: :seller_id
  has_many :received_feedbacks_as_buyer,
    -> { where(direction: 'buyer_to_seller') },
    class_name: 'Feedback',
    foreign_key: :buyer_id

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_size :avatar, :less_than => 9.megabytes
  
  validates_inclusion_of :role, in: ALLOWED_ROLES, allow_blank: false
  # validates_format_of :user_name, :with => /\A[A-Z0-9_]*\z/i
  # validates_length_of :user_name, :within => 3..20, :allow_nil => false, :allow_blank => false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  def self.search(search)
    where("email ILIKE ?", "%#{search}%") 
  end

  def all_feedbacks
    Feedback.for_user(self)
  end

  def received_negative_feedbacks
    Feedback.negative.for_user(self)
  end

  def received_positive_feedbacks
    Feedback.positive.for_user(self)
  end
  
  # after_create :send_welcome_mail
  
  # def send_welcome_mail
  #   UserMailer.sign_up_email(self).deliver
  # end

end

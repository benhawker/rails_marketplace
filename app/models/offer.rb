class Offer < ActiveRecord::Base

  before_save :find_duplicate_offer

	#Constants
  MAX_OFFERS_PER_USER_PER_LISTING = 5
  MAX_LIVE_OFFERS_PER_USER = 10
  STATES = %w(made accepted declined withdrawn lapsed)

	#Associations
	belongs_to :listing
	belongs_to :user

  #Association validations
  validates_presence_of :listing
  validates_presence_of :user

  #Attribute validations
  validates_presence_of :price, message: "Your offer must have a price!"
  validates_numericality_of :price, message: "Please input a valid price"
  validate :max_live_offers_per_user
  validates_inclusion_of :status, in: STATES, allow_blank: false

  #Status/State Machine
  state_machine :status, :initial => :made do
    state :made, :accepted, :declined, :withdrawn, :lapsed

    event :accept_offer do
      transition :made => :accepted
    end

    event :decline_offer do
      transition :made => :declined
    end

    event :withdraw_offer do
      transition :made => :withdrawn
    end

    event :offer_lapsed do
      transition :made => :lapsed
    end
  end

  #Scopes
 # scope :same_offer_info, ->(offer){ where{id.not_eq offer.id}.where(:sender_id => offer.user_id, :listing_id => offer.listing_id) }
  scope :made, ->{ where(status: 'made') }
  scope :accepted, ->{ where(status: 'accepted') }
  scope :declined, ->{ where(status: 'declined') }
  scope :withdrawn, ->{ where(status: 'withdrawn') }
  scope :lapsed, ->{ where(status: 'lapsed') }
  

  def same_offer_info_as(offer)
    if Offer.where(user_id: offer.user_id, listing_id: offer.listing_id)
      raise "You already have a live offer on this listintg."
    end
  end

  private

  def find_duplicate_offer
    self.same_offer_info_as(self).where(status: "made").first
  end

	def max_live_offers_per_user
		# if User.offers.count > MAX_LIVE_OFFERS_PER_USER
		# 	errors.add(:base, 'You cannot have more than 15 live offers at any one time.')
		# end
	end

end

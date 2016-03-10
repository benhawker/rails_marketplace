class Feedback < ActiveRecord::Base

  before_save :cannot_leave_feedback_on_your_own_listing

  ##Proposed better solution to be reworked
  belongs_to :author, :foreign_key => :author_id, :class_name => "User"
  belongs_to :recipient, :foreign_key => :recipient_id, :class_name => "User"
  belongs_to :listing

  #Association validations
  validates_presence_of :author
  validates_presence_of :recipient
  validates_presence_of :listing#, uniqueness: { scope: [:seller_id, :buyer_id, :direction], message: "Bob" }

  #Attribute validations
	validates_presence_of :rating, message: "Your feedback must have a rating"
	validates_presence_of :comment, message: "Your feedback must have a comment"

	#Scopes
  scope :negative, -> { where(rating: false) }
  scope :positive, -> { where(rating: true) }

  def positive?
    self.rating
  end

  def negative?
    !positive?
  end

  private

  def listing_must_be_complete
    errors.add(:id, "Feedback can't be created for this listing yet.") if self.listing && !self.listing.ready_for_feedback?
  end

  def cannot_leave_feedback_on_your_own_listing
    raise "You cannot leave feedback on your own listing." if self.seller.id == self.listing.user.id
  end

end

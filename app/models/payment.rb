class Payment < ActiveRecord::Base

	VALID_STATES = ["paid", "pending", "cancelled"]

  belongs_to :listing_transaction, foreign_key: "payment_id", class_name: "Transaction"
  belongs_to :payer, foreign_key: "payer_id", :class_name => "User"
  belongs_to :recipient, foreign_key: "recipient_id", :class_name => "User"

  validates_inclusion_of :status, in: VALID_STATES, allow_blank: false
end

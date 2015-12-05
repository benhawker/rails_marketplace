class Inquiry < ActiveRecord::Base
	belongs_to :listing
	belongs_to :sender, :foreign_key => :sender_id, class_name: "User"
	belongs_to :recipient, :foreign_key => :recipient_id, class_name: "User"
  has_many :messages, dependent: :destroy, validate: false

	accepts_nested_attributes_for :messages, reject_if: proc { |attributes| attributes["message"].blank? }

	validates_uniqueness_of :sender_id, :scope => :recipient_id
	
	scope :between, -> (sender_id,recipient_id) do
		where("(inquiries.sender_id = ? AND inquiries.recipient_id =?) OR (inquiries.sender_id = ? AND inquiries.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
	end

end

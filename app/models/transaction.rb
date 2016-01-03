class Transaction < ActiveRecord::Base
	belongs_to :listing
  has_many :feedbacks, dependent: :destroy
end

class Message < ActiveRecord::Base
	belongs_to :user
  belongs_to :inquiry

	validates_presence_of :body, :inquiry_id, :user_id

	# def message_time
	# 	created_at.strftime(“%m/%d/%y at %l:%M %p”)
	# end
	
end

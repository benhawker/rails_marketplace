# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview
	def sign_up_email_preview
    UserMailer.sign_up_email(User.first)
  end
end

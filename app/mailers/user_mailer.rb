class UserMailer < ApplicationMailer
	default from: "ben.c.hawker@gmail.com"

  def sign_up_email(user)
    @user = user
    mail(to: @user.email, subject: 'Succes - you are signed up!')
  end
end

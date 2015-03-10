class UserMailer < ApplicationMailer
  default from: 'birthdays@example.com'
 
  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to Light IT')
  end
  
  def password_reset(user)
    @user = user
    mail to: user.email, subject: 'Reset Password'
  end
end

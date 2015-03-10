class PasswordResetsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email]);
    @user.send_password_reset if @user
    flash[:success] = "Email sent with password reset instructions."
    redirect_to root_path
  end
  
  def edit
    @user = User.find_by_password_resets_token(params[:id])
  end
  
  def update
    @user = User.find_by_password_resets_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      flash[:success] = "Password reset has expired."
      redirect_to new_password_reset_path
    elsif @user.update_attributes(params[:user])
      flash[:success] = "Password has been reset!"
      redirect_to root_url 
    else
      render :edit
    end
  end
end

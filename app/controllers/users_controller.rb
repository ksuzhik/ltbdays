class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy
  
  def index
    @users = User.search(params[:search]).paginate(:page => params[:page])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @user = User.new()
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_later
      flash[:success] = "Welcome to the Sample App!"
      sign_in @user
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    attributes = user_params;
    attributes[:avatar] = params[:user][:avatar]
    if @user.update_attributes(attributes)
      flash[:success] = "Profile updated"
      render 'edit'
    else
      render 'edit'
    end
  end
  
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted."
    respond_to do |format|
      format.html { redirect_to users_url }
      format.js
    end
  end
  
  private
    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :birthdate,
        :password, :password_confirmation)
    end

end

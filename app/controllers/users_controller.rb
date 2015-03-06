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
  
  def events
    @date =  params[:month] ? Date.parse(params[:month]) : Date.today
    @users = event_users(@date.month, @date.year)
    @debug_out = @users
    respond_to do |format|
      format.html
      format.js
      format.json {render json: @users}
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

    def signed_in_user
      store_location
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(signin_url) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    def event_users(month, year)
      User.select(:id, :first_name, :last_name, :avatar,
        "STR_TO_DATE(CONCAT(DAY(birthdate), ' #{month} #{year}'),'%d %m %Y') as this_year_birthdate")
      .where('MONTH(birthdate) = ?', month)
    end
end

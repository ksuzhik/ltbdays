class UserEventsController < ApplicationController
  def index
    @date =  params[:month] ? Date.parse(params[:month]) : Date.today
    @users = event_users(@date.month, @date.year)
    respond_to do |format|
      format.html
      format.js
      format.json {render json: @users}
    end
  end
  
  private
    def event_users(month, year)
      User.select(:id, :first_name, :last_name, :avatar,
        "STR_TO_DATE(CONCAT(DAY(birthdate), ' #{month} #{year}'),'%d %m %Y') as this_year_birthdate")
      .find_by_birth_month(month)
    end
end

class AdminsController < ApplicationController
  before_filter :signed_in_user, :admin_user
  def index
  end
end

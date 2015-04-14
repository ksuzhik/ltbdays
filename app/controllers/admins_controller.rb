class AdminsController < ApplicationController
  before_filter :signed_in_user, :admin_user
  
  def download_pdf
    list = UsersListPDF.new
    list.table_headers = User.find_by_birth_month Date.today.month
    output = list.to_pdf User.all
    send_data output, :type => 'application/pdf', :filename => "users.pdf"
  end

end

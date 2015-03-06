class ChangeDefaultValues < ActiveRecord::Migration
  def change
    change_column_null :users, :first_name, false
    change_column_null :users, :last_name, false
    change_column_null :users, :email, false
    change_column_null :users, :birthdate, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :admin, false
    change_column_default :users, :admin, false
  end
end

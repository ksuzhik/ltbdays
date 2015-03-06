class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.date :birthdate
      t.string :password_digest
      t.boolean :admin
      t.string :remember_token
      t.timestamps null: false
    end
  end
end

class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.integer :month
      t.decimal :payment_sum
      t.timestamps null: false
    end
  end
end

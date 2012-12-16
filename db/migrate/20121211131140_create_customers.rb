class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :name
      t.string :email
      t.integer :user_id
      t.string :password_visible
      t.string :username
      t.timestamps
    end
  end
end

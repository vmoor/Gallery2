class CreateAlbums < ActiveRecord::Migration
  def change
    create_table :albums do |t|
      t.string :title
      t.integer :customer_id
      t.timestamps
    end
  end
end

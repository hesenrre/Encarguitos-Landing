class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.float :lat
      t.float :lng
      t.string :name
      t.integer :phone
      t.text :addrs
      t.text :comments

      t.timestamps
    end
  end
end

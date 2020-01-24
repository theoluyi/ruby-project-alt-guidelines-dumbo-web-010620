class CreateDevs < ActiveRecord::Migration[5.2]
  def change
    create_table :devs do |t|
      t.string :dev_name
      t.integer :cash
    end 
  end
end

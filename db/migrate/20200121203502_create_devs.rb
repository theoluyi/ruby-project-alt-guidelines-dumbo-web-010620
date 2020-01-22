class CreateDevs < ActiveRecord::Migration[5.2]
  def change
    create_table :devs do |t|
      t.string :name
      t.integer :cash
    end 
  end
end

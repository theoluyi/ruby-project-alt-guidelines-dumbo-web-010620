class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.integer :action_id
      t.integer :dev_id
      t.integer :payment
    end 
  end
end

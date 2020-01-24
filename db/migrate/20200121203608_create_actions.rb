class CreateActions < ActiveRecord::Migration[5.2]
  def change
    create_table :actions do |t|
      t.string :action_name
      # t.integer :payment # can connect and adjust payments by pulling via action.id and make a loop.
      #testing..
    end 
  end
end

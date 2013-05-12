class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |list|
       list.string :name
       list.timestamps
     end
  end
end

class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |tag|
       tag.integer :task_id
       tag.string :content
       tag.timestamps
     end
  end
end

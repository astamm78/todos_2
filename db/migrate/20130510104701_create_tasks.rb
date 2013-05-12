class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |task|
       task.integer :list_id
       task.string :content
       task.boolean :completed, default: "false"
       task.timestamps
     end
  end
end

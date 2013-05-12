class AddTagsToTasks < ActiveRecord::Migration

  def up
    add_column :tasks, :tag, :string
  end

  def down
    remove_column :tasks, :tag
  end

end

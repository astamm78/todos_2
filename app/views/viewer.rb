class Viewer

  def view_lists(array)
    array.each do |list|
      puts "ID: #{list.id} Name: #{list.name}"
    end
  end

  def list(array)
    array.each do |item|
      if item.completed == true
        print_complete = "[X]"
      else
        print_complete = "[ ]"
      end
      output = ""
      output << "List: #{List.find_by_id(item.list_id).name} ".ljust(14)
      output << "ID: #{item.id} #{item.content}".ljust(65)
      output << "#{print_complete}".rjust(20)
      tags = []
      Tag.find_all_by_task_id(item.id).each { |tag| tags << tag.content }
      output << "  Tags: #{tags.join(", ")}"
      puts output
    end
  end

  def new_list(list_name)
    puts "You have added the list, \'#{list_name}\'"
  end

  def deleted_confirm(task)
    puts "You have deleted the task, \'#{task}\'."
  end

  def deleted_error
    puts "Please enter a valid Todo id to delete."
  end

  def help
    puts "Add \'view:lists\' to view all Lists"
    puts "Add \'view:list LIST_NAME\' to view Tasks for a single List."
    puts "Add \'view:all\' to view all Tasks, sorted by time added."
    puts "Add \'view:completed\' to view all completed Tasks."
    puts "Add \'view:outstanding\' to view all outstanding Tasks."
    puts "Add \'view:tags TAG\' to view Tasks by tags."
    puts "Add \'add:list LIST_NAME\' to add a new empty List."
    puts "Add \'delete:task TASK_NUMBER\' to delete a Task."
    puts "Add \'complete:task TASK_NUMBER\' to mark a Task as completed."
    puts "Add \'add:task LIST_NAME TASK\' to add a new Task to a specific List."
    puts "Add \'tag:task TASK_NUMBER TAG\' to add a Tag to a Task."
  end

  def help_message
    puts "Add \'help\' to view all Arguments."
  end

  def completed_message(id)
    puts "You have completed Todo item no. #{id}."
  end

  def added_task(task, list_name)
    puts "You have added \'#{task}\' to your \'#{list_name}\' list."
  end

  def added_tag(task_id, tag)
    puts "You have added the tag \'#{tag}\' to Task no. #{task_id}."
  end

end

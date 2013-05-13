class Controller

  def initialize
    @viewer = Viewer.new
  end

  def run_command(input)
    command = input.shift
    arguments = input.join(" ")

    if command == "view:lists"
      view_lists
    elsif command == "view:list"
      view_single(arguments)
    elsif command == "view:all"
      list_tasks
    elsif command == "add:list"
      add_list(arguments)
    elsif command == "delete:task"
      delete_task(arguments.to_i)
    elsif command == "complete:task"
      mark_task_complete(arguments.to_i)
    elsif command == "add:task"
      add_task(arguments)
    elsif command == "view:completed"
      view_completed
    elsif command == "view:outstanding"
      view_outstanding
    elsif command == "tag:task"
      add_tag_to_task(arguments)
    elsif command == "view:tags"
      view_by_tag(arguments)
    elsif command == "help"
      @viewer.help
    else
      @viewer.help_message
    end
  end

  def view_lists
    @viewer.view_lists(List.all)
  end

  def view_single(list_name)
    tasks = Task.find_all_by_list_id(List.find_by_name(list_name).id)
    @viewer.list(tasks)
  end

  def add_list(list_name)
    List.create(:name => list_name)
    @viewer.new_list(list_name)
  end

  def list_tasks
    @viewer.list(Task.all)
  end

  def delete_task(id)
    deleted_task = Task.find_by_id(id).content
    deleted = Task.delete(id)
    if deleted == 1
      @viewer.deleted_confirm( deleted_task )
    elsif deleted == 0
      @viewer.deleted_error
    end
  end

  def mark_task_complete(id)
    Task.update(id, :completed => 't')
    @viewer.completed_message(id)
  end

  def view_completed
    @viewer.list( Task.find_all_by_completed('t') )
  end

  def view_outstanding
    @viewer.list( Task.find_all_by_completed('f') )
  end

  def add_task(task)
    task = task.split
    list_name = task.shift
    task = task.join(" ")
    Task.create(:list_id => List.find_by_name(list_name).id, :content => task)
    @viewer.added_task(task, list_name)
  end

  def add_tag_to_task(arguments)
    arguments = arguments.split
    task_id = arguments.shift.to_i
    tag = arguments.join(" ")
    Tag.create(:task_id => task_id, :content => tag)
    @viewer.added_tag(task_id, tag)
  end

  def view_by_tag(tag)
    results = []
    Tag.where(:content => tag).each { |tag| results << tag.task_id }
    results.each { |task_id| @viewer.list( Task.where(:id => task_id) ) }
  end

end

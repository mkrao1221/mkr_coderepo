require "date"

class Todo
  def initialize(text1, due_date1, completed1)
    @text = text1
    @due_date = due_date1
    @completed = completed1
  end

  def is_due_today?
    @due_date == Date.today
  end

  def is_overdue?
    @due_date < Date.today
  end

  def is_due_later?
    @due_date > Date.today
  end

  def to_displayable_string
    if (@completed == true)
      @flag = "X"
    else
      @flag = " "
    end
    if (is_due_today? == true)
      @printdate = " "
    else
      @printdate = @due_date
    end

    strout = "[#{@flag}] #{@text} #{@printdate}"
    return strout
  end
end

class TodosList
  def initialize(todos)
    @todos = todos
  end

  def add(todo)
    @todos.push(todo)
  end

  def overdue
    TodosList.new(@todos.filter { |todo| todo.is_overdue? })
  end

  def due_today
    TodosList.new(@todos.filter { |todo| todo.is_due_today? })
  end

  def due_later
    TodosList.new(@todos.filter { |todo| todo.is_due_later? })
  end

  def to_displayable_list
    @todos.map { |todo| puts todo.to_displayable_string }.join("\n")
  end
end

date = Date.today
todos = [
  { text: "Submit assignment", due_date: date - 1, completed: false },
  { text: "Pay rent", due_date: date, completed: true },
  { text: "File taxes", due_date: date + 1, completed: false },
  { text: "Call Acme Corp.", due_date: date + 1, completed: false },
]

todos = todos.map { |todo|
  Todo.new(todo[:text], todo[:due_date], todo[:completed])
}

todos_list = TodosList.new(todos)

todos_list.add(Todo.new("Service Your vehicle", date, false))

puts "My Todo-list\n\n"

puts "Overdue\n"
puts todos_list.overdue.to_displayable_list
puts "\n\n"

puts "Due Today\n"
puts todos_list.due_today.to_displayable_list
puts "\n\n"

puts "Due Later\n"
puts todos_list.due_later.to_displayable_list
puts "\n\n"

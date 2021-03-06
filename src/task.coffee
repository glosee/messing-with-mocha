class Task
  constructor: (@name) ->
    @status = 'incomplete'

  complete: ->
    if @parent? and @parent.status isnt 'complete'
      throw new Error "Dependent task '#{@parent.name}' is not completed"
    @status = 'complete'
    yes

  dependsOn: (@parent) ->
    @parent.child = @
    @status = 'dependent'

class TaskList
  constructor: ->
    @tasks = []
    @length = 0

  add: (task) ->
    if typeof task is 'string'
      @tasks.push(new Task task)
    else
      @tasks.push task
    @length = @tasks.length

  addToDom: ->
    taskListItems = []
    taskListItems = @tasks.map (task, count) ->
      return "<li><p>#{task.name}</p><span> - #{task.status}</span></li>"
    $list = $('<ul></ul>')
    for item in taskListItems
      $list.append item
    $('body').append $list

  remove: (task) ->
    i = @tasks.indexOf task
    @tasks = @tasks[0...i].concat @tasks[i+1..] if i > -1
    @length  = @tasks.length

  print: ->
    str = "Tasks\n\n"
    for task in @tasks
      str += "- #{task.name}"
      str += " (depends on '#{task.parent.name}')" if task.parent?
      str += " (complete)" if task.status is 'complete'
      str += "\n"
    str

  # Example method to show when code is not covered by unit tests
  doStuff: ->
    console.log 'doing some stuff'
    div = $ '<div>'
    $('body').append div

# Export to either module.exports or `window` for DOM testing
root = exports ? window
root.Task = Task
root.TaskList = TaskList

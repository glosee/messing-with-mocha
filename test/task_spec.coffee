{Task, TaskList} = require '../src/task'

describe 'Task instance', ->

  task1 = task2 = null

  it 'should have a name', ->
    task1 = new Task 'feed the cat'
    expect(task1.name).to.equal 'feed the cat'

  it 'should be initially incomplete', ->
    expect(task1.status).to.equal 'incomplete'

  it 'should be able to be completed', ->
    expect(task1.complete()).to.equal yes
    expect(task1.status).to.equal 'complete'

  it 'should be able to be dependent on another task', ->
    task1 = new Task 'wash the dishes'
    task2 = new Task 'dry the dishes'

    task2.dependsOn task1

    expect(task2.status).to.equal 'dependent'
    expect(task2.parent).to.equal task1
    expect(task1.child).to.equal task2

  it 'should refuse completion if it is dependent on an uncompleted task', ->
    expect((-> task2.complete())).to.throw(
      'Dependent task \'wash the dishes\' is not completed'
    )

describe 'TaskList instance', ->
  taskList = null

  it 'should start with no tasks', ->
    taskList = new TaskList
    expect(taskList.tasks.length).to.equal 0
    expect(taskList.length).to.equal 0

  it 'should accept new tasks as tasks', ->
    taskList.add new Task 'remember the milk'
    expect(taskList.tasks[0].name).to.equal 'remember the milk'
    expect(taskList.length).to.equal 1

  it 'should accept new tasks as strings', ->
    taskList.add 'take out garbage'
    expect(taskList.tasks[1].name).to.equal 'take out garbage'
    expect(taskList.length).to.equal 2

  it 'should allow you to remove tasks by passing a task to remove', ->
    i = (taskList.length - 1)
    taskList.remove taskList.tasks[i]
    expect(taskList.tasks[i]).to.not.be.ok

  it 'should print out your list of tasks', ->
    taskList = new TaskList

    task1 = new Task 'buy milk'
    task2 = new Task 'go to store'
    task3 = new Task 'get beer'
    task4 = new Task 'go to group'
    task5 = new Task 'sub-task'
    task6 = new Task 'sub-sub-task'

    taskList.add task1
    taskList.add task2
    taskList.add task3
    taskList.add task4
    taskList.add task5
    taskList.add task6

    task1.dependsOn task2
    task5.dependsOn task4
    task6.dependsOn task5

    task2.complete()

    desiredOutput = """Tasks

    - buy milk (depends on 'go to store')
    - go to store (complete)
    - get beer
    - go to group
    - sub-task (depends on 'go to group')
    - sub-sub-task (depends on 'sub-task')

    """

    expect(taskList.print()).to.equal desiredOutput

  it 'should add a list of tasks to the DOM', ->
    taskList.addToDom()
    expect($('ul').length).to.equal 1
    expect($('li').length).to.equal taskList.length

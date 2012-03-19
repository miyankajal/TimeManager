class TasksController < ApplicationController
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        format.html { redirect_to @task, notice: 'Task was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  # Find 
  	
  def getAllTAsksForUser(user_id)
		
	@tasks = Task.find(:all,:joins => "INNER JOIN user_tasks ON user_tasks.tasks_id = tasks.id INNER JOIN users ON user_tasks.users_id = users.id",/
			:select => 'tasks.name, tasks.description, tasks.status', :conditions => 'users.id = 16')
  end
  
  def getTasksDueToday
	@tasks = getAllTAsksForUser(params[:user_id])
	@tasks = @tasks.where("due_date = ?", Date.today)
  end
  
  def getEveryDayTasks
	@tasks = getAllTAsksForUser(params[:user_id])
	@tasks = @tasks.where("due_date IS NULL")
  end
  
  def getPercentageTasksNotDone
	
  end
  
  def getTasksCompletedToday
  end
  
  def getPercentageTasksCompletedToday
  end
  
   # @task = Task.find(:all, :select => "task_statuses.status, tasks.name", :joins => "INNER JOIN task_statuses ON tasks.task_status_id = task_statuses.id")
#Task.create(:name => 'John's stuff', :description => 'summa vetti', :task_status_id => 2)
#User.find(:all)
#Task.find(:all, :joins => "INNER JOIN user_tasks ON user_tasks.task_id = tasks.id INNER JOIN users ON user_tasks.user_id = users.id")
  def tada
  end
  
end

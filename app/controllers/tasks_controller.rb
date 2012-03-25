class TasksController < ApplicationController

  before_filter :authenticate
  before_filter :authorized_user, :only => :destroy
  before_filter :find_task, :only => [:edit, :create, :update, :show, :destroy]
  
  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = current_user.tasks

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
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
  
  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @movie }
    end
  end


  # GET /tasks/1/edit
  def edit
  
  end

  # POST /tasks
  # POST /tasks.json
  def create
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
    @task.destroy

    respond_to do |format|
      format.html { redirect_to tasks_url }
      format.json { head :no_content }
    end
  end

  private
  
    def authorized_user
      @task = current_user.tasks.find_by_id(params[:id])
      redirect_to root_path if @task.nil?
    end
	
	def find_task
      @task = current_user.tasks.find(params[:id])
    end

  
  =begin
  def getTasksDueToday
	@tasks = Task.getAllTAsksForUser(params[:user_id])
	@tasks = @tasks.where("due_date = ?", Date.today)
  end
  
  def getEveryDayTasks
	@tasks = Task.getAllTAsksForUser(params[:user_id])
	@tasks = @tasks.where("due_date IS NULL")
  end
  
  def getPercentageTasksNotDone
	
  end
  
  def getTasksCompletedToday
  end
  
  def getPercentageTasksCompletedToday
  =end
  
   # @task = Task.find(:all, :select => "task_statuses.status, tasks.name", :joins => "INNER JOIN task_statuses ON tasks.task_status_id = task_statuses.id")
#Task.create(:name => 'John's stuff', :description => 'summa vetti', :task_status_id => 2)
#User.find(:all)
#Task.find(:all, :joins => "INNER JOIN user_tasks ON user_tasks.task_id = tasks.id INNER JOIN users ON user_tasks.user_id = users.id")

  
end

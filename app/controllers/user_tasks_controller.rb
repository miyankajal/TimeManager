class UserTasksController < ApplicationController	
  before_filter :authenticate
  
  # POST /user_tasks
  # POST /user_tasks.json
  def create
    @task = Task.find(params[:user_task][:tasks_id])
	current_user.craete_task!(@task)
    respond_to do |format|
      if @user_task.save
        format.html { redirect_to @user_task, notice: 'User Task was successfully created.' }
        format.json { render json: @user_task, status: :created, location: @user_task }
      else
        format.html { render action: "new" }
        format.json { render json: @user_task.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_tasks/1
  # DELETE /user_tasks/1.json
  def destroy
    @user_task = UserTask.find(params[:id]).task
    @user_task.destroy

    respond_to do |format|
      format.html { redirect_to user_tasks_url }
      format.json { head :no_content }
    end
  end
end

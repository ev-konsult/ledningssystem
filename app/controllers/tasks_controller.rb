class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)
    @user_ids = params[:users][:user_id]

    if @task.save
      # Add the users to the task if the task can be saved.
      # Else it somehow trys to validate a user and cannot save the task...
      # TODO: Try to figure out why it behaves this way
      @user_ids.each do |id|
        next if id.blank?
        @task.users << User.find(id)
      end
      flash[:success] = "Blabalbal"
      redirect_to @task
    else
      flash.now[:danger] = "Bla bla!"
      render 'new'
    end
  end

  def update
  end

  def edit
    @task = Task.find(params[:id])
  end

  private

    def task_params
      params.require(:task).permit(:start, :end, :priority, :title, :description)
    end
end

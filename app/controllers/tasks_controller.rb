class TasksController < ApplicationController
  def new
    @task = Task.new
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      flash[:success] = "Blabalbal"
      redirect_to @task
    else
      flash.now[:danger] = "Bla bla!"
      render 'new'
    end
  end

  private

    def task_params
      params.require(:task).permit(:start, :end, :priority, :title, :description)
    end
end

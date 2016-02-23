class TasksController < ApplicationController
  before_action :check_if_logged_in, only: [:create, :destroy, :update, :edit, :new]
  before_action :check_if_admin, only: [:new, :create, :destroy]

  def new
    @task = Task.new
  end

  def index
    @tasks = Task.all
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @user_ids = params[:user_ids]

    if @task.save
      # Add the users to the task if the task can be saved.
      # Else it somehow trys to validate a user and cannot save the task...
      # TODO: Try to figure out why it behaves this way
      @user_ids.each do |id|
        next if id.blank?
        @task.users << User.find(id)
      end
      flash[:success] = "Uppgiften skapades!"
      redirect_to @task
    else
      render 'new'
    end
  end

  def update
    @task = Task.find(params[:id])
    @user_ids = params[:user_ids]

    if @task.update_attributes(task_params)
      @user_ids.each do |id|
        next if id.blank?
        user = User.find(id)

        # No duplication of users
        @task.users << user unless @task.users.include?(user)
      end

      flash[:success] = "Uppgiften uppdaterades!"
      redirect_to @task
    else
      render 'edit'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  private

    def task_params
      params.require(:task).permit(:start, :end, :priority, :title, :description)
    end
end

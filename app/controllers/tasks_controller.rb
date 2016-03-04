class TasksController < ApplicationController
  before_action :check_if_logged_in, only: [:create, :destroy, :update, :edit, :new]
  before_action :check_privilege, only: [:new, :create, :destroy]

  def new
    @task = Task.new
  end

  def index
    @tasks = Task.paginate(:page => params[:page], :per_page => 3)
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @user_ids = params[:user_ids]

    if @task.save
      unless @user_ids.nil?
        @user_ids.each do |id|
          next if id.blank?
          user = User.find(id)

          @task.users << User.find(id)
        end
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
      # Remove already assigned users
      @task.users.each do |user|
        @task.users.delete(user)
      end

      unless @user_ids.nil?
        @user_ids.each do |id|
          next if id.blank?
          user = User.find(id)

          # No duplication of users
          @task.users << user
        end
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
      params.require(:task).permit(:start, :end, :priority, :status, :title, :description)
    end

    def check_privilege
      redirect_to current_user unless current_user.admin? ||
                                      current_user.project_manager?
    end
end

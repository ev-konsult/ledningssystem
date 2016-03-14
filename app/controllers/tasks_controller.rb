class TasksController < ApplicationController
  # Controller that handles everything about the tasks.
  # Creates, updates, destroys & reads.
  before_action :check_if_logged_in, only: [:create, :destroy, :update, :edit, :new]
  before_action :check_privilege, only: [:new, :create, :destroy]

  STATUS       = "Status"
  RISING       = "Stigande"
  TASK_CREATED = "Uppgiften skapades!"

  def new
    @task = Task.new
  end

  def index
    condition = :priority if params[:sort].nil?
    sort_order = :asc if params[:sort_order].nil?

    if params[:sort] == STATUS
      condition = :status
    else
      condition = :status
    end

    if params[:sort_order] == RISING
      sort_order = :asc
    else
      sort_order = :desc
    end

    @tasks = Task.order(condition => sort_order).paginate(:page => params[:page], :per_page => 10)
  end

  def show
    @task = Task.find(params[:id])
  end

  def create
    @task = Task.new(task_params)
    @user_ids = params[:user_ids]

    if @task.save
      # If there are user id's in the params, attach these to the task
      unless @user_ids.nil?
        @user_ids.each do |id|
          # There is always one blank ID for some reason. We haven't
          # figured out why, so skip that ID with the following line.
          next if id.blank?
          user = User.find(id)

          @task.users << User.find(id)
        end
      end
      flash[:success] =
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

      # Reassign users
      unless @user_ids.nil?
        @user_ids.each do |id|
          next if id.blank?
          user = User.find(id)

          @task.users << user
        end
      end

      flash[:success] = TASK_CREATED
      redirect_to tasks_path
    elsif @task.update_attributes params[:status]
      @task.status = params[:status]
      @task.save
      render 'index'
    else
      render 'edit'
    end
  end

  def edit
    @task = Task.find(params[:id])
  end

  private
    # Strong parameters that whitelists params that is used in this controller.
    def task_params
      params.require(:task).permit(:start, :end, :priority, :status, :title, :description)
    end

    def check_privilege
      redirect_to current_user unless current_user.admin? ||
                                      current_user.project_manager?
    end
end

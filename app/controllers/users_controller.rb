class UsersController < ApplicationController
  before_action :check_privilege, only: [:new, :create, :destroy, :index]
  before_action :check_if_logged_in, only: [:show, :index, :create, :destroy, :new]

  def new
    @user = User.new

    # This creates the form fields for the nested attributes (contact person)
    @user.build_contact_person
  end

  def index
    # Determine sort condition
    condition = :full_name if params[:sort].nil?
    sort_order = :asc if params[:sort_order].nil?
    # paging_size = 5 if params[:paging_size].nil?

    if params[:paging_size].nil?
      paging_size = 5
    else
      paging_size = params[:paging_size]
    end



    @user = User.new
    @user.build_contact_person

    case params[:sort]
    when "Användarnamn"
      condition = :user_name
    when "Förnamn"
      condition = :first_name
    when "Efternamn"
      condition = :last_name
    when "E-post"
      condition = :email
    when "Registrerad"
      condition = :created_at
    end



    if params[:sort_order] == "Stigande"
      sort_order = :asc
    else
      sort_order = :desc
    end

    # Paginated users. Change ":per_page" value to get more/less users per page
    if params[:search]
      # User.order instead of search for sort-order (asc and desc)
      @users = User.order(condition => sort_order).paginate(:page => params[:page], :per_page => paging_size).search(params[:search])
    else
      10.times { puts "hehehe" }
      10.times { puts paging_size }
      @users = User.order(condition => sort_order).paginate(:page => params[:page], :per_page => paging_size)
    end

    respond_to do |format|
      format.js # index.js.erb
      format.html # intex.html.erb
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "Du gav personen sparken, bra jobbat!"
    redirect_to users_path
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.role = Role.find(user_params[:role_id])
    end

    respond_to do |format|
      format.html { redirect_to @user }
      format.js
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      flash[:success] = "Användaren uppdaterades"
      redirect_to @user
    else
      render 'edit'
    end
  end

  # Redirects to login or current user depending on if you're logged in
  def user_root
    if logged_in?
      redirect_to current_user
    else
      redirect_to login_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :first_name, :last_name, :password, :password_confirmation, :phone_number, :ssn, :email, :role_id,
                                 contact_person_attributes: [:id, :full_name, :email, :phone_number])
                                 # ^ Nested attributes for contact_person
  end

  def check_privilege
    redirect_to current_user unless current_user.admin? ||
                                    current_user.human_resources?
  end


end

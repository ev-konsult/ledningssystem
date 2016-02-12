class UsersController < ApplicationController
  before_action :check_if_admin, only: [:new, :create, :destroy, :index]
  before_action :authorize_login, only: [:show, :index, :create, :destroy]

  def new
    @user = User.new
    @user.build_contact_person
  end

  def index
    # Sidindelade användare, 5 användare per sida
    if params[:search]
      @users = User.paginate(:page => params[:page], :per_page => 5).search(params[:search])
    else
      @users = User.paginate(:page => params[:page], :per_page => 5)
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
      flash[:success] = "Du har registrerat en ny anställd!"

      # Redirect till current user istället för den nya användaren,
      # eftersom det bara är admin som kan skapa profiler
      redirect_to current_user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :first_name, :last_name, :password, :password_confirmation, :phone_number, :ssn, :email,
                                 contact_person_attributes: [:id, :full_name, :email, :phone_number])
                                 # ^ Nästlade attribut för contact_person
  end

  # Skickar tillbaka ickeadmins till deras profiler eller loginsidan
  # Bra att köra innan saker som bara admin ska få göra
  def check_if_admin
    unless logged_in?
      redirect_to login_path
    else
      unless current_user.admin?
        redirect_to current_user
      end
    end
  end
end

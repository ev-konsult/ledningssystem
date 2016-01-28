class UsersController < ApplicationController
  before_action :check_if_admin, only: [:new, :create, :destroy, :index]

  def new
    @user = User.new
  end

  def index
    # Sidindelade användare, 5 användare per sida
    @users = User.paginate(:page => params[:page], :per_page => 5)
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
    params.require(:user).permit(:name, :password, :password_confirmation)
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

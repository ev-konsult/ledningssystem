class UsersController < ApplicationController
  before_action :check_if_admin, only: :new

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = "Du har registrerat en ny användare!"

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

  # Skickar tillbaka ickeadmins till deras profiler
  # Bra att köra innan redirects till adminsidor
  def check_if_admin
    unless current_user.admin?
      redirect_to current_user
    end
  end
end

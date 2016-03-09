class EducationsController < ApplicationController
  before_action :check_if_logged_in, only: [:create, :destroy, :update, :edit, :new]
  before_action :fetch_user, only: [:create, :destroy]
  before_action :check_if_admin, only: [:new, :create, :destroy]

  def create
    @education = @user.educations.create(education_params)

    respond_to do |format|
      format.html { redirect_to @user }
      format.js # educations/create.js.erb
    end
  end

  def destroy

  end

  private
    def education_params
      params.require(:education).permit(:name, :school, :graduation)
    end

    def fetch_user
      @user = User.find(params[:user_id])
    end
end

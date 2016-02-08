class EducationsController < ApplicationController
  before_action :fetch_user, only: [:create, :destroy]
  def create
    @education = @user.educations.build(education_params)
    if @education.save
      flash[:success] = "Utbildning tillagd"
    else
      flash[:danger] = "Någon gick fel, försök igen!" # visa felmeddelanden
    end
    redirect_to @user
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

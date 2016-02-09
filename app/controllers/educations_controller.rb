class EducationsController < ApplicationController
  before_action :fetch_user, only: [:create, :destroy]
  def create
    @education = @user.educations.build(education_params)
    if @education.save
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    else
      flash[:danger] = "Någon gick fel, försök igen!" # visa felmeddelanden
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

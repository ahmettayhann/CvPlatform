class ResumesController < ApplicationController
  before_action :require_login, except: [:index, :show]
  before_action :set_resume, only: [:show, :edit, :update, :destroy]
  
  def index
    @resumes = Resume.page(params[:page]).per(10)
  end
  
  def show
  end
  
  def new
    @resume = current_user.resumes.build
  end
  
  def create
    @resume = current_user.resumes.build(resume_params)
    if @resume.save
      redirect_to @resume, notice: 'Resume was successfully created.'
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @resume.update(resume_params)
      redirect_to @resume, notice: 'Resume was successfully updated.'
    else
      render :edit
    end
  end
  
  def destroy
    @resume.destroy
    redirect_to resumes_url, notice: 'Resume was successfully destroyed.'
  end
  
  private
  
  def set_resume
    @resume = Resume.find(params[:id])
  end
  
  def resume_params
    params.require(:resume).permit(:title, :description, :hobbies, :active, :file,
                                   resume_schools_attributes: [:id, :school_id, :start_date, :end_date, :_destroy])
  end
end
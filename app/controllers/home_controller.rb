class HomeController < ApplicationController
  skip_before_action :require_login, only: [:index]

  def index
    @q = Resume.includes(:user).ransack(params[:q])
    @resumes = @q.result.page(params[:page]).per(10)

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
end
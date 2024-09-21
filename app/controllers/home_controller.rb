class HomeController < ApplicationController
  def index
    @q = Resume.includes(:user).ransack(params[:q])
    
    if params[:q].present?
      @resumes = @q.result(distinct: true).active
    else
      @resumes = Rails.cache.fetch("all_active_resumes", expires_in: 5.minutes) do
        Resume.includes(:user).active.to_a
      end
    end
  end
end
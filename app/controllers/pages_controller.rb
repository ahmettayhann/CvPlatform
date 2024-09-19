class PagesController < ApplicationController
  def home
    @resumes = Resume.where(active: true).includes(:user)
  end
end

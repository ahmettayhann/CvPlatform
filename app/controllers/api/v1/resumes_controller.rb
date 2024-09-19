module Api
  module V1
    class ResumesController < ApplicationController
      def index
        @resumes = Resume.active
        @resumes = @resumes.where("title LIKE ?", "%#{params[:search]}%") if params[:search].present?
        render json: @resumes.map { |r| { id: r.id, title: r.title, full_name: r.user.full_name } }
      end

      def show
        @resume = Resume.find(params[:id])
        render json: @resume.as_json(include: { user: { only: [:first_name, :last_name, :email, :gsm] } })
      end
    end
  end
end
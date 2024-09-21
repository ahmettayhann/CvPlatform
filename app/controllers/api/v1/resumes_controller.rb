module Api
  module V1
    class ResumesController < BaseController
      def index
        @q = Resume.includes(:user).where(active: true).ransack(params[:q])
        resumes = @q.result(distinct: true)
        render json: { resumes: resumes }, each_serializer: Api::V1::ResumeListSerializer
      end

      def show
        resume = Resume.find_by(id: params[:id])
        if resume
          render json: resume, serializer: Api::V1::ResumeSerializer
        else
          render json: { error: 'Resume not found' }, status: :not_found
        end
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Resume not found' }, status: :not_found
      end
    end
  end
end
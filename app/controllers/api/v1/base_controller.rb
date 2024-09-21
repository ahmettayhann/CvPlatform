module Api
  module V1
    class BaseController < ApplicationController
      skip_before_action :require_login, if: :api_request?
      before_action :authenticate_request, if: :api_request?

      attr_reader :current_user

      private

      def authenticate_request
        header = request.headers['Authorization']
        header = header.split(' ').last if header
        begin
          decoded = JWT.decode(header, Rails.application.secrets.secret_key_base, true, algorithm: 'HS256')
          @current_user = User.find(decoded.first['id'])
        rescue JWT::DecodeError, ActiveRecord::RecordNotFound
          render json: { errors: ['Not Authenticated'] }, status: :unauthorized
        end
      end
    end
  end
end
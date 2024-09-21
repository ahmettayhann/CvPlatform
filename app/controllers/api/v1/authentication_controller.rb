module Api
  module V1
    class AuthenticationController < BaseController
      skip_before_action :authenticate_request

      def authenticate
        user = User.find_by(email: auth_params[:email])
        if user&.authenticate(auth_params[:password])
          token = user.generate_jwt
          render json: { auth_token: token }
        else
          render json: { error: 'Invalid credentials' }, status: :unauthorized
        end
      end

      private

      def auth_params
        params.permit(:email, :password)
      end
    end
  end
end
module Api
  module V1
    class RegistrationsController < BaseController
      skip_before_action :authenticate_request

      def create
        user = User.new(user_params)
        if user.save
          token = user.generate_jwt
          render json: { 
            auth_token: token,
            user: UserSerializer.new(user)
          }, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :first_name, 
          :last_name, 
          :email, 
          :password, 
          :password_confirmation, 
          :country, 
          :gsm, 
          :identity_number
        )
      end
    end
  end
end
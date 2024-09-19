class UsersController < ApplicationController
  skip_before_action :require_login, only: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    byebug
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully'
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to root_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  private

  def user_params
    byebug
    params.require(:user).permit(:first_name, :last_name, :email, :gsm, :country, :identity_number, :password, :password_confirmation)
  end
end
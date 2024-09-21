class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, unless: :api_request?
  include ApplicationHelper
  before_action :require_login
  helper_method :current_user, :logged_in?, :flash_class#, :current_page_class

  private

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_login
    unless logged_in?
      flash[:alert] = "You must be logged in to access this page"
      redirect_to login_path
    end
  end

  def flash_class(level)
    case level.to_sym
    when :notice then "bg-blue-100 border-l-4 border-blue-500 text-blue-700 p-4 rounded-md"
    when :success then "bg-green-100 border-l-4 border-green-500 text-green-700 p-4 rounded-md"
    when :error then "bg-red-100 border-l-4 border-red-500 text-red-700 p-4 rounded-md"
    when :alert then "bg-yellow-100 border-l-4 border-yellow-500 text-yellow-700 p-4 rounded-md"
    else "bg-gray-100 border-l-4 border-gray-500 text-gray-700 p-4 rounded-md"
    end
  end

  private

  def api_request?
    request.format.json? || request.path.start_with?('/api/')
  end

  # def current_page_class(path)
  #   current_page?(path) ? 'bg-gray-900 text-white' : 'text-gray-300 hover:bg-gray-700 hover:text-white'
  # end
end
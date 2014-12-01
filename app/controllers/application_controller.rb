class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def restrict_access
    if !current_user  
      flash[:alert] = "You must log in."
      redirect_to new_session_path
    end
  end

  def restrict_admin_access
    if !session[:impersonated_user_id]
      flash[:alert] = "You are not allowed to access admin panel"
      redirect_to movies_path
    end
  end

  def impersonator
    @impersonator_user ||= User.find(session[:impersonated_user_id]) if session[:impersonated_user_id]
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
     current_user.admin?
  end

  # def change_current_user(selected_user)
  #   if current_user != selected_user
  #     current_user = User.find_by(email: selected_user.email)
  #     puts "selected_user's email = #{selected_user.email}"
  #   end
  # end

  helper_method :current_user, :current_admin, :impersonator
end

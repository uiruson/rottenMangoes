class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to movies_path, notice: "Welcome back, #{user.firstname}"
    else
      flash.now[:alert] = "Log in failed..."
      render :new
    end
  end

  def set_impersonator(selected_user)
    puts "----I AM IN----"
    puts "selected_user = #{selected_user.firstname}"
    session[:impersonated_user_id] = selected_user.id
  end

  def destroy
    session[:user_id] = nil
    redirect_to movies_path, notice: "Adios!"
  end

end

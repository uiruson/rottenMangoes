class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @users = User.all
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    if current_user.admin?
      session[:impersonated_user_id] = @user.id
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to movies_path, notice: "Welcome aboard, #{@user.firstname}!"
    else
      render :new
    end
  end

  def change_user
    session[:user_id] = params[:id]
    redirect_to movies_path
  end

  protected
  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation)
  end

  
end

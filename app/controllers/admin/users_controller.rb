class Admin::UsersController < ApplicationController
  def index
    @admin_users = User.all.page(params[:page]).per(2)
  end

  def new
    @admin_user = User.new
  end


  def create
    @admin_user = User.new(admin_user_params)

    if @admin_user.save
      redirect_to admin_users_path, notice: "New user created in admin dashboard, #{@admin_user.email}"
    else
      render :new
    end
  end

  def edit
    @admin_user = User.find(params[:id])
  end

  def update
    @admin_user = User.find(params[:id])
    
    if @admin_user.update_attributes(admin_user_params)
      redirect_to admin_users_path
    else
      render :edit
    end

  end

  def destroy
    @admin_user = User.find(params[:id])
    @admin_user.destroy
    redirect_to admin_users_path, notice: "User deleted!"
  end

  protected
  def admin_user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end
end



 
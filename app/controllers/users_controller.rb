class UsersController < ApplicationController
  include UsersHelper
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

  def show
    require_user
    @user = User.find(params[:id])
  end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end
end

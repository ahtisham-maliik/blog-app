class UserController < ApplicationController
  before_action :set_user, only:[:full_name]

  def index
    @users =User.all
  end

  def full_name
    full_name = @user.first_name + " " + @user.last_name
    full_name.capitalize
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end
end

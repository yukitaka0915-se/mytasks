class UsersController < ApplicationController
  after_action :after_signup, only:[:create]

  def index
  end

  def edit
  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

  def after_signup
    redirect_to root_path
  end

end

class UserProfileController < ApplicationController
  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end


  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to user_profile_path
    else
      render :edit
    end
  end
end

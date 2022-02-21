class UsersController < ApplicationController
  private

  def users_params
    params.require(:users).permit(:first_name, :last_name, :presentation, :photo)
  end
end

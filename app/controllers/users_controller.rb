class UsersController < ApplicationController

   def show
    
   end
  private

  def users_params
    params.require(:users).permit(:first_name, :last_name, :presentation, :photo)
  end
end

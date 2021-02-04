class UsersController < ApplicationController

  def def new
  end
  
  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      flash[:success] = "Object successfully created"
      redirect_to "/"
    else
      flash[:error] = "Something went wrong"
      render '/signup'
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

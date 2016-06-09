class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update]
  
  def edit
    @user = User.find(params[:id])
    if (current_user!= @user)
      redirect_to root_path
    end
  end
    
  def update
    @user = User.find(params[:id])
    if @user.update(edit_params)
      redirect_to @user
    flash[:success] = "Your Profile has been updated"
    else
      render 'edit'
    end
  end
      
  def show 
   @user = User.find(params[:id])
  end 
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end  
    
  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
  
  def edit_params
    params.require(:user).permit(:name, :email, :location, :profile)
  end
  
  
end  

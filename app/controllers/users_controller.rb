class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :followers, :followings]
  
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
    flash[:success] = "Your Profile has been updated!"
    else
      render 'edit'
    end
  end
      
  def show 
   @user = User.find(params[:id])
   @microposts = @user.microposts.order(created_at: :desc)
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
  
  def followings
    @title = "Followings"
    @user = User.find(params[:id])
    @users = @user.following_users
    render 'show_follow'
  end
  
  def followers
    @title = "Followers"
    @user = User.find(params[:id])
    @users = @user.follower_users
    render 'show_follow'
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

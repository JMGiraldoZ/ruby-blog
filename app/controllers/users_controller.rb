class UsersController < ApplicationController
  def index
    @users = User.all
  end
  def show
    @user = User.find(params[:id])
  end

  def following
    @title = 'Follows'
    @user  = User.find(params[:id])
    @users = @user.following
    render 'users/show_follow'
  end

  def followers
    @title = 'Followers'
    @user  = User.find(params[:id])
    @users = @user.followers
    render 'users/show_follow'
  end
end

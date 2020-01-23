# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :already_exists, only: [:create]

  def index
    @users = User.all
  end

  def new
    @users = User.new
  end

  def create
    @users = User.new(user_params)
    if @users.save
      redirect_to login_path
    else
      flash[:error] = "Couldn't register"
      render 'new'
    end
  end

  def update
    if @users.update(users_params)
      redirect_to users_path(@users)
    else
      render :edit
    end
  end

  def user_params
    params[:user].permit(:email_id, :password, :contact_no, :user_name)
  end

  def already_exists
    user = User.find_by(email_id: user_params[:email_id])
    return if user.blank?

    flash[:already] = 'User Already Exists'
    redirect_to new_user_path
  end
end

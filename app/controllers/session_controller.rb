# frozen_string_literal: true

# Session Controller
class SessionController < ApplicationController
  before_action :load_user, only: [:create]

  def new; end

  def create
    if @user.password == params[:session][:password]
      session[:user_id] = @user.id
      redirect_to profile_path
    else
      flash.now[:error] = 'Invalid login credentials'
      render 'index'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'Successfully logged out'
    redirect_to login_path
  end

  def load_user
    @user = User.find_by(email_id: params[:session][:email_id])
    return unless @user.nil?

    flash.now[:error] = 'Email Id not registered'
    render 'index'
  end
end

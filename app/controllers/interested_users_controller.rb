# frozen_string_literal: true

# Interested Users Controller
class InterestedUsersController < ApplicationController
  def new; end

  def show; end

  def approve
    @interested = InterestedUser.where(property_id: params[:id])
    @interested.destroy_all
    @property = Property.find_by(id: params[:id])

    @property.tenant_id = params[:user_id]
    @property.availability = 'unavailable'
    @property.save
    redirect_to your_properties_path
  end

  def index
    @interested = InterestedUser.where(property_id: params[:property_id])

    @property = Property.find_by(id: params[:property_id])
    @users = @interested.pluck(:user_id)
    @interested_users = User.where(id: @users)
  end

  def interested_properties
    @interested = InterestedUser.where(user_id: session[:user_id])
    @interested_properties = @interested.pluck(:property_id)
    @interested_properties = Property.where(id: @interested_properties)
  end

  def create
    @property = Property.find_by(id: params[:property_id])
    if (session[:user_id] != @property.owner_id) && InterestedUser.find_by(user_id: session[:user_id], property_id: params[:property_id]).nil?
      @interested_user = InterestedUser.new(user_id: session[:user_id],
                                            property_id: params[:property_id])
      @interested_user.save
    else
      flash[:error] = 'Its ur own property'
    end
    redirect_to filtered_properties_path
  end

  def destroy
    @interested_user = InterestedUser.where(user_id: params[:id])
    @interested_user = @interested_user.find_by(property_id:
                                                params[:property_id])
    @interested_user.destroy
    redirect_to property_interested_users_path
  end

  def remove
    @interested = InterestedUser.where(property_id: params[:id])
    @interested = @interested.find_by(user_id: session[:user_id])
    @interested.destroy

    redirect_to interested_properties_path
  end
end

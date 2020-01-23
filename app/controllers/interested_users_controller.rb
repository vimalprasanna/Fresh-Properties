# frozen_string_literal: true

# Interested Users Controller
class InterestedUsersController < ApplicationController
  def new; end

  def show; end

  def approve
    destroy_interested_users if change_availability
    redirect_to your_properties_path
  end

  def index
    @interested = InterestedUser.where(property_id: params[:property_id])
    @property = Property.find_by(id: params[:property_id])
    user_ids = @interested.pluck(:user_id)
    @interested_users = User.where(id: user_ids)
  end

  def interested_properties
    interested_users = InterestedUser.where(user_id: session[:user_id])
    interested_property_ids = interested_users.pluck(:property_id)
    @interested_properties = Property.where(id: interested_property_ids)
  end

  def create
    property_id = params[:property_id]
    property = Property.find_by(id: property_id)
    user_id = session[:user_id]
    if (user_id != property.owner_id) && already_registered?
      @interested_user = InterestedUser.new(user_id: user_id,
                                            property_id: property_id)
      @interested_user.save
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

  private

  def destroy_interested_users
    @interested = InterestedUser.where(property_id: params[:id])
    @interested.destroy_all
  end

  def change_availability
    @property = Property.find_by(id: params[:id])
    @property.tenant_id = params[:user_id]
    @property.availability = 'unavailable'
    @property.save
  end

  def already_registered?
    InterestedUser.find_by(user_id: session[:user_id],
                           property_id: params[:property_id]).nil?
  end
end

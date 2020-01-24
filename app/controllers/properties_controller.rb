# frozen_string_literal: true

# Properties Controller
class PropertiesController < ApplicationController
  before_action :load_property, only: [:index]

  def index
    return unless property_params

    location_filter if property_params[:location].present?

    rent_filter if property_params[:rent].present?

    property_type_filter if property_params[:property_type].present?
  end

  def show
    @properties = Property.includes(:owner)
                          .where('owner_id=?', session[:user_id].to_s)
                          .references(:owner)
  end

  def new
    @property = Property.new
  end

  def edit; end

  def create
    @property = Property.new(property_params)
    if @property.save

      flash[:success] = 'successfully added'
      redirect_to your_properties_path
    else
      redirect_to new_property_path
    end
  end

  def block; end

  def destroy
    @property = Property.find_by(id: params[:id])
    @property.destroy
    flash[:danger] = 'Property successfully Removed'
    redirect_to your_properties_path
  end

  def unblock
    Property.remove_tenant(params[:id])
    # property.unblock
    redirect_to your_properties_path
  end

  private

  def property_params
    return unless params[:property].present?

    params[:property].permit(:name, :rent, :location, :property_type, :image)
  end

  def location_filter
    @properties = @properties.where(location: property_params[:location]
                             .downcase)
  end

  def property_type_filter
    @properties = @properties.where(property_type:
                                    property_params[:property_type])
  end

  def rent_filter
    @properties = @properties.where('rent<' + property_params[:rent].to_s)
  end

  def load_property
    interested = InterestedUser.where(user_id: session[:user_id])
    interested_properties_ids = interested.pluck(:property_id)
    @properties = Property.where(tenant_id: nil)
    @properties = @properties.where.not(id: interested_properties_ids)
    @properties = @properties.where('owner_id!=' + session[:user_id].to_s)
  end
end

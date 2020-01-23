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
    @property = Property.where('owner_id=' + session[:user_id].to_s)
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
    property_id = params[:id]
    property = Property.find_by(id: property_id)
    interested = InterestedUser.where(property_id: property_id)
    comments = Comment.where(property_id: property_id)
    comments.destroy_all
    interested.destroy_all
    property.destroy
    flash[:danger] = 'Property successfully Removed'
    redirect_to your_properties_path
  end

  def unblock
    @property = Property.find_by(id: params[:id])
    @property.availability = 'available'
    @property.save
    redirect_to your_properties_path
  end

  private

  def property_params
    return unless params[:properties].present?

    params[:properties].permit(:name, :rent, :location, :property_type, :image)
    params[:properties][:location].downcase
    params[:properties].merge(availability: 'available')
  end

  def location_filter
    @property = @property.where(location: property_params[:location])
  end

  def property_type_filter
    @property = @property.where(property_type: property_params[:property_type])
  end

  def rent_filter
    @property = @property.where('rent<' + property_params[:rent].to_s)
  end

  def load_property
    @interested = InterestedUser.where(user_id: session[:user_id])
    @interested_properties = @interested.pluck(:property_id)
    @property = Property.where(availability: 'available')
    @property = @property.where.not(id: @interested_properties)
    @property = @property.where('owner_id!=' + session[:user_id].to_s)
  end
end

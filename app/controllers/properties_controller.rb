# frozen_string_literal: true

# Properties Controller
class PropertiesController < ApplicationController
  def index
    @interest = InterestedUser.where(user_id: session[:user_id])
    @interested = @interest.pluck(:property_id)
    @property = Property.where(availability: 'available')
    @property = @property.where.not(id: @interested)
    @property = @property.where('owner_id!=' + session[:user_id].to_s)
    if params[:properties].present?
      if params[:properties][:location].present?
        @property = @property.where(location:
                                    params[:properties][:location].downcase)
      end
      if params[:properties][:rent].present?
        @property = @property.where('rent<' + params[:properties][:rent].to_s)
      end
      if params[:properties][:property_type].present?
        @property = @property.where(property_type:
                                    params[:properties][:property_type])
      end
    end
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
    @property = Property.find_by(id: params[:id])
    @interested = InterestedUser.where(property_id: params[:id])
    @comments = Comment.where(property_id: params[:id])
    @comments.destroy_all
    @interested.destroy_all
    @property.destroy
    flash[:danger] = 'Property successfully Removed'
    redirect_to your_properties_path
  end

  def unblock
    @property = Property.find_by(id: params[:id])
    @property.availability = 'available'
    @property.save
    redirect_to your_properties_path
  end

  def property_params
    params[:property].permit(:name, :rent, :location, :property_type, :image)
    params[:property][:location].downcase
    params[:property].merge(availability: 'available')
  end
end

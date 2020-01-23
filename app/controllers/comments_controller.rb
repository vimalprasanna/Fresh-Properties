# frozen_string_literal: true

# Comments Controller
class CommentsController < ActionController::Base
  def index
    @property = Property.find_by(id: params[:property_id])
    @comment = Comment.where(property_id: params[:property_id])
    @comment = @comment.where.not(sender_id: session[:user_id])
    @sender = @comment.pluck(:sender_id)
    @sender = User.where(id: @sender)
  end

  def user_specific_comments
    @comment = Comment.where(sender_id: params[:user_id],
                             property_id: params[:property_id])
                      .or(Comment.where(receiver_id: params[:user_id],
                                        property_id: params[:property_id]))
    @comment = @comment.order(created_at: :asc)
  end

  def show; end

  def new
    @comment = Comment.new
  end

  def create
    new_comment_params = comment_params.merge(sender_id: session[:user_id])
    @comment = Comment.new(new_comment_params)
    # comment: params[:comments][:comment], sender_id: session[:user_id],
    # property_id: params[:property_id],
    # receiver_id: comment_params[:receiver_id])
    if @comment.save
      flash[:success] = 'comment saved'
      redirect_back fallback_location: filtered_properties_path
    else
      flash[:error] = 'comment cannot be saved'
      redirect_to filtered_properties_path
    end
  end

  def delete; end

  def my_comments
    @comment = Comment.where(sender_id: session[:user_id],
                             property_id: params[:property_id])
                      .or(Comment.where(receiver_id: session[:user_id],
                                        property_id: params[:property_id]))
    @comment = @comment.order(created_at: :asc)
  end

  private

  def comment_params
    params.permit(:sender_id, :property_id, :comments, :receiver_id)
  end
end

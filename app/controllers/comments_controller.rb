# frozen_string_literal: true

# Comments Controller
class CommentsController < ActionController::Base
  def index
    @comments = Comment.where(property_id: params[:property_id])
    @comments = @comments.includes(:sender)
                         .where.not(sender_id: session[:user_id])
                         .references(:sender)
  end

  def user_specific_comments
    @comments = Comment.where(sender_id: params[:user_id],
                              property_id: params[:property_id])
                       .or(Comment.where(receiver_id: params[:user_id],
                                         property_id: params[:property_id]))
    @comments = @comments.includes(:sender).order(created_at: :asc)
                         .references(:sender)
  end

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

  def my_comments
    @comment = Comment.where(sender_id: session[:user_id],
                             property_id: params[:property_id])
                      .or(Comment.where(receiver_id: session[:user_id],
                                        property_id: params[:property_id]))
    @comment = @comment.includes(:sender).order(created_at: :asc).references(:sender)
  end

  private

  def comment_params
    params.permit(:sender_id, :property_id, :comment, :receiver_id)
  end
end

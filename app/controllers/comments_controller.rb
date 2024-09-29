class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link
  before_action :set_comment, only: [:reply, :destroy]

  def create
    @comment = @link.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @link, notice: 'Comment was successfully created.'
    else
      @comments = @link.comments.where(parent_id: nil).includes(:user, :replies)
      render 'links/show'
    end
  end

  def new
    @comment = Comment.new
  end

  def reply
    @comment = Comment.new(parent_id: @parent_comment.id)
    render :new
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
      redirect_to @link, notice: 'Comment was successfully deleted.'
    else
      redirect_to @link, alert: 'You are not authorized to delete this comment.'
    end
  end

  private

  def set_link
    @link = Link.find(params[:link_id])
  end

  def set_comment
    @parent_comment = @link.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
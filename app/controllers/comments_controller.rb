class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_link

  def create
    @comment = @link.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      respond_to do |format|
        format.html { redirect_to @link, notice: 'Comment was successfully created.' }
        format.turbo_stream
      end
    else
      respond_to do |format|
        format.html { redirect_to @link, alert: 'Error creating comment.' }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("comment_form", partial: "comments/form", locals: { link: @link, comment: @comment }) }
      end
    end
  end

  def destroy
    @comment = @link.comments.find(params[:id])
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

  def comment_params
    params.require(:comment).permit(:content, :parent_id)
  end
end
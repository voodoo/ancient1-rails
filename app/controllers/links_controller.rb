class LinksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  before_action :set_link, only: [:show, :upvote, :downvote]

  def index
    @links = Link.rank
  end

  def new
    @link = current_user.links.build
  end

  def show
    @link = Link.find(params[:id])
    @comments = @link.comments.where(parent_id: nil).includes(:user, :replies)
    @comment = Comment.new
  end   

  def best
    @links = Link.best
  end

  def create
    @link = current_user.links.build(link_params)

    if @link.save
      redirect_to root_path, notice: 'Link was successfully submitted.'
    else
      render :new
    end
  end

  def upvote
    @link.votes.create(user: current_user, value: 1)
    respond_to do |format|
      format.html { redirect_to links_path }
      format.turbo_stream
    end
  end

  def downvote
    @link.votes.create(user: current_user, value: -1)
    respond_to do |format|
      format.html { redirect_to links_path }
      format.turbo_stream
    end
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end

  def set_link
    @link = Link.find(params[:id])
  end
end
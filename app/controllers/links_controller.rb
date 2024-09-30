class LinksController < ApplicationController
  before_action :set_link, only: [:show, :upvote, :downvote]
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @links = Link.all.includes(:user).sort_by(&:score).reverse
  end

  def new
    @link = current_user.links.build
  end

  def show
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
    @link.upvote(current_user)
    redirect_back fallback_location: root_path
  end

  def downvote
    @link.downvote(current_user)
    redirect_back fallback_location: root_path
  end

  private

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end

  def set_link
    @link = Link.find(params[:id])
  end
end
class LinksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @links = Link.rank
  end

  def new
    @link = current_user.links.build
  end

  def show
    @link = Link.find(params[:id])
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
    @link = Link.find(params[:id])
    @link.votes.create(user: current_user, value: 1)
    respond_to do |format|
      format.html { redirect_to links_path }
      format.turbo_stream
    end
  end

  def downvote
    @link = Link.find(params[:id])
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
end
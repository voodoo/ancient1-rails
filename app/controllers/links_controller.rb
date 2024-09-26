class LinksController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def index
    @links = Link.all.order(created_at: :desc)
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

  private

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end

end
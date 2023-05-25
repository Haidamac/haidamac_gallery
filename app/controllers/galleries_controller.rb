class GalleriesController < ApplicationController
  before_action :set_gallery, only: :show

  def index
    @galleries = Gallery.all
  end

  def show
    @photos = @gallery.photos
    @breadcrumb = @gallery
    redirect_to photos_path(gallery_id: @gallery.id)
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:id])
  end

  def gallery_params
    params.require(:gallery).permit(:name)
  end
end

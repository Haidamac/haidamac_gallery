class PhotosController < ApplicationController
  before_action :set_gallery, only: :index
  before_action :set_photo, only: :show

  def index
    @photos = @gallery.photos
  end

  def show
    @photo
  end

  private

  def set_gallery
    @gallery = Gallery.find(params[:gallery_id])
  end

  def set_photo
    @photo = Photo.find(params[:id])
  end

  def photo_params
    params.require(:photo).permit(:title, :description, :gallery_id, :image)
  end
end

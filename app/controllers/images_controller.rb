class ImagesController < ApplicationController
  def new
    @image = Image.new
  end

  def create
    @image = Image.create(image_params)
    redirect_to image_path(@image)
  end

  def show
    @image = Image.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: @image, serializer: ImageSerializer }
    end
  end

  protected

    def image_params
      params.require(:image).permit(:file)
    end

end
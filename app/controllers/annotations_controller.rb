class AnnotationsController < ApplicationController
  def create
    image = Image.find(params[:annotation][:image_id])
    @annotation = image.annotations.build(annotation_params)
    @annotation.save!
    render json: @annotation
  end

  def update
    @annotation = Annotation.find(params[:id])
    @annotation.update!(annotation_params)
    render json: @annotation
  end

  def destroy
    @annotation = Annotation.find(params[:id])
    @annotation.destroy
    render json: {}
  end

  protected

    def annotation_params
      params.require(:annotation).permit(:top, :left, :text)
    end

end
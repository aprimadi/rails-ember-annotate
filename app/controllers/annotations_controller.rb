class AnnotationsController < ApplicationController
  def create
    image = Image.find(params[:annotation][:image_id])
    @annotation = image.annotations.build(annotation_params)
    @annotation.save!
    render json: @annotation, serializer: AnnotationSerializer
  end

  protected

    def annotation_params
      params.require(:annotation).permit(:top, :left, :text)
    end

end
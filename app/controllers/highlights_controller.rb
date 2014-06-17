class HighlightsController < ApplicationController
  def create
    image = Image.find(params[:highlight][:image_id])
    @highlight = image.highlights.create(highlight_params)
    render json: @highlight
  end

  def destroy
    @highlight = Highlight.find(params[:id])
    @highlight.destroy
    render json: {}
  end

  protected

    def highlight_params
      params.require(:highlight).permit(:top, :left, :width, :height)
    end

end
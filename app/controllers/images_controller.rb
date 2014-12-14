class ImagesController < ApplicationController
  before_action :set_image, only: [:destroy, :show, :update]


  # GET /images
  # GET /images.json
  def index
    @images = Image.all
    @images = @images.where("tags LIKE ?", "%"+params[:tag]+"%") if params[:tag]
    render json: @images
  end


  def show
    render json: @image
  end

  # POST /images
  # POST /images.json

  def create
    @image = Image.new(image_params)
    @image.save ? render(text:'Ok') : render(text: 'Error')
  end

  # PATCH/PUT /images/1
  # PATCH/PUT /images/1.json
  def update
    @image.update(image_params) ? render(text:'Ok') : render(text: 'Error')
  end


  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.file.clear
    @image.destroy
    render text:'Ok'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_image
    @image = Image.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def image_params
    params.require(:image).permit(:file, :tags)
  end
end

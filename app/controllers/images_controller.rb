class ImagesController < ApplicationController
  before_action :set_image, only: [:destroy]

  # GET /images
  # GET /images.json
  def index
    @images = Image.all
    @image = Image.new
    respond_to do |format|
        format.html { render }
        format.json { render layout:false}
    end

  end

  # POST /images
  # POST /images.json
  def create
    @image = Image.new(image_params)

    respond_to do |format|
      if @image.save
        format.html { redirect_to images_path, notice: 'Image was successfully created.' }
        format.json { render json: 'Image was successfully created.' }
      else
        format.html { render :index, notice: 'Error creating image' }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /images/1
  # DELETE /images/1.json
  def destroy
    @image.file.clear
    @image.destroy
    respond_to do |format|
      format.html { redirect_to images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
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

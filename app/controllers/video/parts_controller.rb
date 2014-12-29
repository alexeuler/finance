class Video::PartsController < ApplicationController
  before_action :set_video_part, only: [:show, :edit, :update, :destroy]

  def index
    @video_parts = Video::Part.all
    respond_with(@video_parts)
  end

  def show
    respond_with(@video_part)
  end

  def new
    @video_part = Video::Part.new
    respond_with(@video_part)
  end

  def edit
  end

  def create
    @video_part = Video::Part.new(part_params)
    flash[:notice] = 'Video::Part was successfully created.' if @video_part.save
    respond_with(@video_part)
  end

  def update
    flash[:notice] = 'Video::Part was successfully updated.' if @video_part.update(part_params)
    respond_with(@video_part)
  end

  def destroy
    @video_part.destroy
    respond_with(@video_part)
  end

  private
    def set_video_part
      @video_part = Video::Part.find(params[:id])
    end

    def video_part_params
      params.require(:video_part).permit(:title, :description, :body, :tags, :status, :slug, :language, :order)
    end
end

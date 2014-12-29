class Video::PartsController < ApplicationController
  before_action :set_video_part, only: [:show, :edit, :update, :destroy]

  def index
    @video_parts = Video::Part.where(video_lesson_id: params[:lesson_id] ).all
    respond_with(@video_parts)
  end

  def show
    respond_with(@video_part)
  end

  def new
    @video_lesson = Video::Lesson.find(params[:lesson_id])
    @video_part = Video::Part.new(video_lesson_id: params[:lesson_id])
    respond_with(@video_part)
  end

  def edit
  end

  def create
    @video_part = Video::Part.new(video_part_params)
    flash[:notice] = 'Video::Part was successfully created.' if @video_part.save
    respond_with(@video_part, url:blog_posts_path)
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
      @video_lesson = Video::Lesson.find(params[:lesson_id])
      @video_part = Video::Part.find(params[:id])
    end

    def video_part_params
      params.require(:video_part).
          permit(:title, :description, :body, :tags,
                 :status, :slug, :language, :order, :lesson_id)
    end
end

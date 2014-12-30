class Video::PartsController < ApplicationController
  before_action :set_video_part, only: [:show, :edit, :update, :destroy]
  layout 'video'

  def index
    @video_parts = Video::Part.where(video_lesson_id: params[:lesson_id] ).all
    video_lesson = Video::Lesson.find(params[:lesson_id])
    @title = video_lesson.title
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
    @video_part.video_lesson_id = params[:lesson_id]
    flash[:notice] = 'Video::Part was successfully created.' if @video_part.save
    respond_with(@video_part,
                 location:video_lesson_part_path(
                     lesson_id:@video_part.video_lesson_id,
                     id:@video_part.id
                 ))
  end

  def update
    flash[:notice] = 'Video::Part was successfully updated.' if @video_part.update(video_part_params)
    respond_with(@video_part,
                 location:video_lesson_part_path(
                     lesson_id:@video_part.video_lesson_id,
                     id:@video_part.id
                 ))
  end

  def destroy
    @video_part.destroy
    respond_with(@video_part,
                 location:video_lesson_parts_path
                 )
  end

  private
    def set_video_part
      @video_part = Video::Part.find(params[:id])
    end

    def video_part_params
      params.require(:video_part).permit(:title, :description, :body, :tags,
                 :status, :slug, :language, :order, :image)
    end
end

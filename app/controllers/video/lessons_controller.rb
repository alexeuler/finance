class Video::LessonsController < ApplicationController
  before_action :set_video_lesson, only: [:show, :edit, :update, :destroy]

  def index
    @video_lessons = Video::Lesson.all
    respond_with(@video_lessons)
  end

  def show
    respond_with(@video_lesson)
  end

  def new
    @video_lesson = Video::Lesson.new
    respond_with(@video_lesson)
  end

  def edit
  end

  def create
    @video_lesson = Video::Lesson.new(lesson_params)
    flash[:notice] = 'Video::Lesson was successfully created.' if @video_lesson.save
    respond_with(@video_lesson)
  end

  def update
    flash[:notice] = 'Video::Lesson was successfully updated.' if @video_lesson.update(lesson_params)
    respond_with(@video_lesson)
  end

  def destroy
    @video_lesson.destroy
    respond_with(@video_lesson)
  end

  private
    def set_video_lesson
      @video_lesson = Video::Lesson.find(params[:id])
    end

    def video_lesson_params
      params.require(:video_lesson).permit(:title, :description, :image, :tags, :order)
    end
end

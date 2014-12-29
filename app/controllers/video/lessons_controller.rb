class Video::LessonsController < ApplicationController
  before_action :set_video_lesson, only: [:show, :edit, :update, :destroy]
  layout 'video'

  def index
    @video_lessons = Video::Lesson.where(language: I18n.locale).
                        order(:order).all
    @video_lessons=@video_lessons.where("tags LIKE ?", "%"+params[:tag]+"%") if params[:tag]
    @video_lesson_tags = Video::LessonTag.where(language: I18n.locale).all
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
    @video_lesson = Video::Lesson.new(video_lesson_params)
    flash[:notice] = 'Video::Lesson was successfully created.' if @video_lesson.save
    respond_with(@video_lesson)
  end

  def update
    flash[:notice] = 'Video::Lesson was successfully updated.' if @video_lesson.update(video_lesson_params)
    respond_with(@video_lesson)
  end

  def destroy
    @video_lesson.destroy
    respond_with(@video_lesson)
  end

  private
    def set_video_lesson
      if params[:slug]
        @video_lesson = Video::Lesson.where(slug: params[:slug]).first
      else
        @video_lesson = Video::Lesson.find(params[:id])
      end
    end

    def video_lesson_params
      params.require(:video_lesson).permit(:title, :description, :image, :tags, :order, :language)
    end
end

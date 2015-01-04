class Video::LessonsController < ApplicationController
  before_action :set_video_lesson, only: [:show, :edit, :update, :destroy]
  before_action :set_breadcrumbs, only: [:index, :show, :new, :edit]
  skip_before_action :require_admin, only: [:index, :show]
  layout 'video'

  def index
    @video_lessons = Video::Lesson.where(language: I18n.locale).
        order(:order).all
    @video_lessons=@video_lessons.where("tags LIKE ?", "%"+params[:tag]+"%") if params[:tag]
    @video_lessons = @video_lessons.published unless admin?
    @video_lesson_tags = Video::LessonTag.where(language: I18n.locale).all
    respond_with(@video_lessons)
  end

  def show
    respond_to do |format|
      format.html { redirect_to video_lesson_parts_path(lesson_id: @video_lesson.id) }
      format.json { render json: {redirect: video_lesson_parts_url(lesson_id: @video_lesson.id, format: :json)} }
    end

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
    params.require(:video_lesson).permit(:title, :description, :image, :tags, :order, :language, :status)
  end

  def set_breadcrumbs
    @breadcrumbs = []
    @breadcrumbs.push [I18n.t('navbar.video'), video_lessons_path]
  end
end

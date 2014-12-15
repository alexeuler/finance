class Video::PostsController < ApplicationController
  layout 'layouts/video_posts'

  def index
    @video_groups = Video::Group.where(language: I18n.locale).includes(:blog_posts).order(:order).all
  end
end

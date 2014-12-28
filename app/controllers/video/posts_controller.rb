class Video::PostsController < ApplicationController
  layout 'layouts/video_posts'

  def index
    @blog_posts = Blog::Post.
        where(language: I18n.locale).
        where(video_group_id: params[:group]).
        order(:order).all
  end
end

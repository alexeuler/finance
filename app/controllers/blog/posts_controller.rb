class Blog::PostsController < ApplicationController
  before_action :set_blog_post, only: [:show, :edit, :update, :destroy]
  skip_before_action :require_admin, only: [:index, :show]
  layout 'layouts/blog'
  # GET /blog/posts
  # GET /blog/posts.json
  def index
    @blog_posts = Blog::Post.where(language: I18n.locale).order(created_at: :desc).all
    @blog_posts=@blog_posts.where("tags LIKE ?", "%"+params[:tag]+"%") if params[:tag]
    @blog_tags = Blog::Tag.where(language: I18n.locale).all
    respond_to do |format|
      format.html
      format.json {render json: @blog_posts}
      format.rss { render :layout => false }
    end


  end

  # GET /blog/posts/1
  # GET /blog/posts/1.json
  def show
    respond_with(@blog_post)
  end

  # GET /blog/posts/new
  def new
    @blog_post = Blog::Post.new
    respond_with(@blog_post)
  end

  # GET /blog/posts/1/edit
  def edit
  end

  # POST /blog/posts
  # POST /blog/posts.json
  def create
    @blog_post = Blog::Post.new(blog_post_params)
    flash[:notice] = 'Blog::Post was successfully created.' if @video_lesson.save
    respond_with(@blog_post)
  end

  # PATCH/PUT /blog/posts/1
  # PATCH/PUT /blog/posts/1.json
  def update
    flash[:notice] = 'Video::Lesson was successfully updated.' if @video_lesson.update(lesson_params)
    respond_with(@blog_post)
  end

  # DELETE /blog/posts/1
  # DELETE /blog/posts/1.json
  def destroy
    @blog_post.destroy
    respond_with(@blog_post)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_blog_post
      if params[:slug]
        @blog_post = Blog::Post.where(slug: params[:slug]).first
      else
        @blog_post = Blog::Post.find(params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def blog_post_params
      params.require(:blog_post).permit(:title, :body, :tags, :status, :category, :description, :slug,
                                        :language, :rss)
    end
end

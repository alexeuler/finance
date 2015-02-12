class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def index
    @comments = Comment.all
    respond_with(@comments)
  end

  def show
    respond_with(@comment)
  end

  def new
    @comment = Comment.new
    respond_with(@comment)
  end

  def edit
  end

  def create
    if user_signed_in?
      @comment = Comment.new(comment_params)
      @comment.user_id=current_user.id
      @comment.save ? render(text:'Ok') : render(text: 'Error')
    else
      render(text: 'Error')
    end
  end

  def update
    flash[:notice] = 'Comment was successfully updated.' if @comment.update(comment_params)
    respond_with(@comment)
  end

  def destroy
    @comment.destroy
    respond_with(@comment)
  end

  private
    def set_comment
      @comment = Comment.find(params[:id])
    end

    def comment_params
      params.require(:comment).permit(:text, :parent_id, :entity_id, :user_id, :category)
    end
end

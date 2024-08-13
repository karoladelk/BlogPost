class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @blog_post = Blog.find(params[:blog_id])
    @comment = @blog_post.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      redirect_to blog_post_path(@blog_post), notice: 'Comment was successfully posted.'
    else
      redirect_to blog_post_path(@blog_post), alert: 'Failed to post comment.'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end

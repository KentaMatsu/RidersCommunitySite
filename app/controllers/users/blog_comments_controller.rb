class Users::BlogCommentsController < ApplicationController

  def create
    @blog = Blog.find(params[:blog_id])
    blog_comment = BlogComment.new(blog_comment_params)
    blog_comment.user_id = current_user.id
    blog_comment.blog_id = @blog.id
    if blog_comment.save!
      redirect_to blog_path(@blog)
    else
      render 'error'
    end
  end

  def destroy
    @blog = Blog.find(params[:blog_id])
    blog_comment = @blog.blog_comments.find(params[:id])
    blog_comment.destroy
    redirect_to blog_path(@blog)
  end

  private

  def blog_comment_params
    params.require(:blog_comment).permit(:comment)
  end

end

class CommentsController < ApplicationController
  before_action :require_sign_in

  def create
    @post = Post.find(params[:post_id])
    comment = @post.comments.new(comment_params)
    @topic = Topic.find(params[:post_id])
    comment = @topic.comments.new(comment_params)
    comment.user = current_user

    if comment.save
      flash[:notice] = "Comment saved successfully."
      redirect_to [@post.topic, @post] # need to redirect_to topic_post_path?
    else
      flash[:alert] = "Comment failed to save."
      redirect_to [@post.topic, @post] # need to redirect_to topic_post_path?
    end
  end

  def destroy
     @post = Post.find(params[:post_id])
     comment = @post.comments.find(params[:id])
     @topic = Topic.find(params[:post_id])
     comment = @topic.comments.find(params[:id])

     if comment.destroy
       flash[:notice] = "Comment was deleted successfully."
       redirect_to [@post.topic, @post] # need to redirect_to topic_post_path?
     else
       flash[:alert] = "Comment couldn't be deleted. Try again."
       redirect_to [@post.topic, @post] # need to redirect_to topic_post_path?
     end
   end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def authorize_user
     comment = Comment.find(params[:id])
     unless current_user == comment.user || current_user.admin?
       flash[:alert] = "You do not have permission to delete a comment."
       redirect_to [comment.post.topic, comment.post]
     end
   end

end

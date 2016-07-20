module CommentsHelper
  def user_is_authorized_for_comment?(comment)
      current_user && (current_user == comment.user || current_user.admin?)
  end

  def render_comments_for(user)
    if user.comments.any?
     render user.comments
    else
     "<p>You have no comments yet</p>".html_safe
    end
  end
end

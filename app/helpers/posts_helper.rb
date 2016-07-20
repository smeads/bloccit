module PostsHelper
  def user_is_authorized_for_post?(post)
       current_user && (current_user == post.user || current_user.admin?)
  end

  def render_posts_for(user)
    if user.posts.any?
     render user.posts
    else
     "<p>You have no posts yet</p>".html_safe
    end
  end
end

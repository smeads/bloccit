class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :topics
  belongs_to :user

  # belongs_to :commentable, polymorphic: true
  # commentable_id, commentable_type eg "Post"
  # @comment.commentable - would return a post or topic 

  validates :body, length: { minimum: 5 }, presence: true
  validates :user, presence: true
end

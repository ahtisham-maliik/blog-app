class CommentPolicy < ApplicationPolicy

  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def edit?
    user == comment.user
  end

  def update?
    user == comment.user
  end

  def destroy?
    user == comment.user or (user == comment.commentable.group.creator or user == comment.post.group.creator) or user == comment.commentable.user
  end

end


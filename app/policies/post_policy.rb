class PostPolicy < ApplicationPolicy

  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def post_creator?
    user == post.user
  end

  def group_creator?
  user == post.group.creator
  end

  def destroy?
    user == post.user or user == post.group.creator
  end

end


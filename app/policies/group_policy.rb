class GroupPolicy < ApplicationPolicy
  attr_reader :user, :group

  def initialize(user, group)
    @user = user
    @group = group
  end

  def is_member?
    group.users.include?(user)
  end

  def group_creator?
    user == group.creator
  end
end


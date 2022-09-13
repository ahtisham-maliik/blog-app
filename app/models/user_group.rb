class UserGroup < ApplicationRecord
  belongs_to :group
  belongs_to :user

  # validates_uniqueness_of [:user_id, :group_id]
end

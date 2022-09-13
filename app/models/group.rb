class Group < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :posts, dependent: :destroy

  validates :name, length: { minimum: 10, maximum: 100 }, presence: true

  scope :created_by_me, lambda { |user| where(creator_id: user.id)}
  scope :where_i_am_member, lambda { |user| joins(:user_groups).where('user_groups.user_id = :user', user: user.id)}
end

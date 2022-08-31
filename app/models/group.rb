class Group < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups
  has_many :posts, dependent: :destroy

  validates :name, length: { minimum: 10, maximum: 100 }, presence: true

end

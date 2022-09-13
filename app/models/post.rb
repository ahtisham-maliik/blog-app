class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  has_one_attached :image

  has_many :comments, as: :commentable

  validates :title, length: { minimum: 3, maximum: 80 }, presence: true, uniqueness: { scope: :group_id }
  validates :description, length: { minimum: 10, maximum: 1000 }, presence: true
end

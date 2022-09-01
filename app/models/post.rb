class Post < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :title, length: { minimum: 3, maximum: 80 }, presence: true, uniqueness: true
  validates :description, length: { minimum: 10, maximum: 1000 }, presence: true
end

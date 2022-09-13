class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :user_groups, dependent: :destroy
  has_many :groups, through: :user_groups
  has_many :posts, dependent: :destroy
  has_many :comments, as: :commentable

  validates :password, length: { minimum: 6 }, presence: true

  def full_name
    (first_name + " " + last_name).capitalize
  end
end

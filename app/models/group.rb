class Group < ApplicationRecord
  has_many :user_groups, dependent: :destroy
  has_many :users, through: :user_groups

  validates :name, length: { minimum: 10, maximum: 100 }, presence: true

end

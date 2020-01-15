class Group < ApplicationRecord
  belongs_to :user
  # has_many :tasks, dependent: :destroy
  # has_many :tasks, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

end
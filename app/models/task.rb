class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :title, presence: true, uniqueness: true


end

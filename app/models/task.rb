class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :title, presence: true, uniqueness: true

  # カレントユーザーとカレントタスクリストの総数を取得する。
  scope :search_all, -> (user_id, group_id){
    where(user: user_id).where(group: group_id)
  }

  scope :search_completed, -> (user_id, group_id){
    search_all(user_id, group_id).where(completed: true)
  }

end

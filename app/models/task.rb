class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :title, presence: true, uniqueness: true

  # カレントユーザーとカレントタスクリストの総数を取得する。
  scope :search_all, -> (user_id, group_id){
    where(user: user_id).where(group: group_id)
  }

  scope :search_completed, -> {
    has_completed(true)
  }

  scope :search_pending, -> {
    has_completed(false)
  }

  scope :search_warning, -> {
    has_completed(false).where('warning_dt <= ?', "current_date()")
  }

  scope :search_overdue, -> {
    has_completed(false).where('target_dt > ?', "current_date()")
  }

  private

  scope :has_completed, -> (flag){
    where(completed: flag)
  }

end

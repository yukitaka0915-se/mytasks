class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  before_create :task_data
  before_update :task_data

  validates :title, presence: true

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

  # タスク完了の成否を絞り込むscope
  scope :has_completed, -> (flag){
    where(completed: flag)
  }

  # create、updateの前にデータを加工する。
  def task_data
    unless self.target_dt == nil and self.warning_st_days == nil
      self.warning_dt = self.target_dt - self.warning_st_days 
    end
    self.completed_at = Time.now if self.completed == true
  end

end

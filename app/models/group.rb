class Group < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  # has_many :tasks, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  # カレントユーザーのタスクリストを検索する。
  scope :has_with_mytasklist, -> (user_id){
    where(user: user_id)
  }

  # タスクリスト「リマインダー」を検索する。
  scope :search_reminder, -> (user_id){
    where(user: user_id).where(authority: true).where(name: 'リマインダー')
  }

  def judge_task_completed
    judge_completed.present?
  end

  def show_task_completed_count
    if (task_completed = judge_completed).present?
      task_completed.count 
    end
  end

  def show_task_completed_latest_dt
    if (task_completed = judge_completed).present?
      I18n.l(task_completed.last.completed_at)
    end
  end

  private

  def judge_completed
    task_completed = tasks.where(completed: true)
  end

end

class Task < ApplicationRecord
  # association
  belongs_to :user
  belongs_to :group

  # callback
  before_create :set_taskdata
  before_update :set_taskdata
  after_find :get_taskdata

  # validation
  validates :title, presence: true
  validates :priority_id, presence: true

  # インスタンス変数のgetter, setter定義
  attr_accessor :status

  # enum定義
  enum priority_id: {
    "---": 0,
    小: 1,
    中: 2,
    大: 3,
  } 

  # カレントユーザーとカレントタスクリストの総数を取得する。
  scope :search_all, -> (user_id, group_id){
    where(user: user_id).where(group: group_id)
  }

  scope :search_completed, -> {
    has_completed(true)
  }

  scope :search_uncompleted, -> {
    has_completed(false)
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

  scope :search_reminder, -> {
    joins(
      "INNER JOIN groups ON groups.id = tasks.group_id
       INNER JOIN users  ON users.id = tasks.user_id  "
    ).where(
      tasks: { completed: false }
    ).select(
      " users.name as user_name
       ,users.slack_webhook_url
       ,groups.name as group_name
       ,tasks.*
      "
    )
  }


  private

  # タスク完了の成否を絞り込むscope
  scope :has_completed, -> (flag){
    where(completed: flag)
  }

  # create、updateの前にデータを加工する。
  def set_taskdata

    #期限日と警告開始日数が設定されていたら、警告開始日をセット。
    if !self.target_dt.nil? && !self.warning_st_days.nil?
      self.warning_dt = self.target_dt - self.warning_st_days 
    end

    #完了フラグが立ったら、当日で完了日をセット。
    self.completed_at = Time.now if self.completed == true
   
  end

  def get_taskdata
    @status = "normal"
    if self.completed == true
        @status = "complete"
    else
      today = Time.now.to_s(:date)
      if !self.target_dt.nil?
        if self.target_dt.to_s(:date) < today
          @status = "overdue"
        elsif !self.warning_st_days.nil?
          if self.warning_dt.to_s(:date) <= today && today <= self.target_dt.to_s(:date)
            @status = "warning"
          end
        end
      end
    end
  end

end

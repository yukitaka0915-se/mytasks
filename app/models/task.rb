class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  before_create :set_taskdata
  before_update :set_taskdata

  after_find :get_taskdata

  validates :title, presence: true

  attr_accessor :status

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

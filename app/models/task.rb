class Task < ApplicationRecord
  belongs_to :user
  belongs_to :group

  validates :title, presence: true, uniqueness: true

  # カレントユーザーとカレントタスクリストの総数を取得する。
  scope :exists_reminder, -> (user_id){
    where("user_id = ?", user_id).where("authority = true").where("name = 'リマインダー'")
  }
  def show_last_message
    if (last_message = messages.last).present?
      last_message.body? ? last_message.body : '画像が投稿されています'
    else
      'まだメッセージはありません。'
    end
  end
  
end

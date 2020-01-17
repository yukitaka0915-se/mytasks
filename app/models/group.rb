class Group < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  # has_many :tasks, dependent: :restrict_with_error

  validates :name, presence: true, uniqueness: true

  # カレントユーザーのタスクリストを検索する。
  scope :has_with_mytasklist, -> (user_id){
    where("user_id = ?", user_id)
  }

  # タスクリスト「リマインダー」を検索する。
  scope :exists_reminder, -> (user_id){
    where("user_id = ?", user_id).where("authority = true").where("name = 'リマインダー'")
  }

end

module ReminderExists
  extend ActiveSupport::Concern

  private

  # ユーザーのサインアップ後に、タスクリスト「リマインダー」を作成する。
  # 正常に動作していない
  def reminder_exists
    binding.pry
    if @group.count == 0
      Group.create(
        name: "リマインダー",
        user_id: current_user.id,
        authority: true
      )
    end 
  end
end
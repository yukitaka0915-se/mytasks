module ReminderExists
  extend ActiveSupport::Concern

  private

  # ユーザーのサインアップ後に、タスクリスト「リマインダー」を作成する。
  # 正常に動作していない
  def reminder_exists
    if @group.count == 0
      @group = Group.new(
        name: "リマインダー",
        user_id: current_user.id,
        created_at: DateTime.now,
        updated_at: DateTime.now,
        authority: true
      )
      @group.save
    end 
  end
end
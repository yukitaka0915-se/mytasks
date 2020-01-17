module ReminderExists
  extend ActiveSupport::Concern

  private

  def reminder_exists
    if @group.count == 0
      # タスクリスト「リマインダー」を作成する。
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
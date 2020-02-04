class RemindersController < ApplicationController

  def index
    @tasks = Task.search_reminder.order("tasks.user_id, tasks.target_dt")
    if @tasks.length > 0
      send_reminders(@tasks)
    end
    respond_to do |format|
      format.html { redirect_to group_tasks_path(params[:group_id]) }
    end
  end

  private

  def get_reminders
  end

  def send_reminders(tasks)
    massage = ""
    tasks.each do |t|
      # binding.pry
      massage = <<-EOS
      お名前：#{t.user_name}
      タスク名：#{t.title}
      重要度：#{t.priority_id}
      期限日：#{t.target_dt.to_s(:date)}
      EOS
      # binding.pry
      message =  "<!here> " + massage
      notifier = Slack::Notifier.new t.slack_webhook_url
      notifier.ping message
    
    end

  end

  

end

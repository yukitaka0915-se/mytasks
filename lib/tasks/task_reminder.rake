namespace :send_reminder do
  desc "reminderタスクのサンプル"
  task :sample do
    puts "Hello World"
  end
  desc "未完了のタスクをリマインドする"
  task :send_messages => :environment do
    @tasks = Task.search_reminder.order("tasks.user_id, tasks.target_dt")
    if @tasks.length > 0
      send_reminders(@tasks)
    end

  end

  private

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

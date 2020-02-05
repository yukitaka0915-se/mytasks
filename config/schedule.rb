# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

# 実行環境の指定
set :environment, :development
# 出力先logの指定
set :output, "log/crontab.log"

set      :job_template, "source $HOME/.zshrc; $(which zsh) -l -c ':job'"
job_type :runner,       "cd :path && bundle exec rails runner -e :environment ':task' :output"

# every 1.day, at: '6:30 am' do
every 1.minute  do
    rake "send_reminder:send_messages"
end

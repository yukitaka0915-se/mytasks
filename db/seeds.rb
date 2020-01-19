# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


if Rails.env == "development"
  require "date"
  10.times do |i|
    zennum = i.to_s.gsub(/[\uFF61-\uFF9F]+/) { |str| str.unicode_normalize(:nfkc)}
    priority = i % 4
    target_dt = Date.parse("2020-01-20") + i
    target_dt = target_dt.strftime("%Y-%m-%d")
    Task.create!(
      title: "test_#{i}", 
      priority_id: priority, 
      description: "タスクをこなす その#{1}",
      place: "どこでも",
      target_dt: target_dt,
      target_tm: "18:00:00",
      warning_st_days: i,
      completed: false, 
      group_id: 1,
      user_id: 1
    )
  end
end
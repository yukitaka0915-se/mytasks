class CreateTasks < ActiveRecord::Migration[5.2]
  def change
    create_table :tasks do |t|
      t.string :title,        null: false
      t.integer :priority_id
      t.string :description
      t.string :place
      t.date :target_dt
      t.time :target_tm
      t.integer :warning_st_days
      t.date :warning_dt
      t.boolean :completed, null: false, default: false 
      t.datetime :completed_at

      t.references :group, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :tasks, :title, unique: true
    add_index :tasks, :target_dt
    add_index :tasks, :target_tm
    add_index :tasks, :warning_dt
  end
end

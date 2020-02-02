class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.string :name,                 null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
    add_index :groups, :name, unique: true
  end
end

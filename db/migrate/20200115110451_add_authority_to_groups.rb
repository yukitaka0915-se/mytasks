class AddAuthorityToGroups < ActiveRecord::Migration[5.2]
  def change
    add_column :groups, :authority, :boolean
    change_column_default :groups, :authority, from: true, to: false
  end    
end

class AddRoleEnumToRoleAndRemoveRoleNameColumn < ActiveRecord::Migration
  def change
    remove_column :roles, :role_name
    add_column :roles, :role_name_id, :integer
  end
end

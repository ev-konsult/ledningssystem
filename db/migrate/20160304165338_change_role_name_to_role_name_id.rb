class ChangeRoleNameToRoleNameId < ActiveRecord::Migration
  def change
    rename_column :roles, :role_name, :role_name_id

  end
end

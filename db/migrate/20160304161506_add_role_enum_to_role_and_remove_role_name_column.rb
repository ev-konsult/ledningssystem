class AddRoleEnumToRoleAndRemoveRoleNameColumn < ActiveRecord::Migration
  def change
    change_column :roles, :role_name, :integer
  end
end

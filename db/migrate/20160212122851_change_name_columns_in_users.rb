class ChangeNameColumnsInUsers < ActiveRecord::Migration
  def change
    rename_column :users, :name, :user_name
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :full_name, :string
  end
end

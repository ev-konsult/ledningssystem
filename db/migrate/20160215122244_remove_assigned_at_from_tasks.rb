class RemoveAssignedAtFromTasks < ActiveRecord::Migration
  def change
    remove_column :tasks, :assigned_at, :datetime
  end
end

class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.datetime :start
      t.datetime :end
      t.string :title
      t.text :description
      t.datetime :assigned_at
      t.integer :status, default: 0
      t.integer :priority, default: 0

      t.timestamps null: false
    end
  end
end

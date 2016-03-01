class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.string :role_name
      t.boolean :can_edit_news, default: false
      t.boolean :can_edit_staff, default: false
      t.boolean :can_edit_tasks, default: false
      t.boolean :can_edit_documents, default: false
      t.boolean :can_show_person_details_verbose, default: false

      t.timestamps null: false
    end
  end
end

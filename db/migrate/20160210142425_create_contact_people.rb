class CreateContactPeople < ActiveRecord::Migration
  def change
    create_table :contact_people do |t|
      t.belongs_to :user, index: true
      t.string :full_name
      t.string :phone_number
      t.string :email

      t.timestamps null: false
    end
  end
end

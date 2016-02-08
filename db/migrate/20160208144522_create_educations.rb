class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.string :name
      t.string :school
      t.datetime :graduation

      t.timestamps null: false
    end
  end
end

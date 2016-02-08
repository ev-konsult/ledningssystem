class AddUserRefToEducations < ActiveRecord::Migration
  def change
    add_reference :educations, :user, index: true, foreign_key: true
  end
end

class Role < ActiveRecord::Base
  has_many :user
  # Enum role_name maps against the integer-column of the same name in the db
  # Kinda retarded but at least it eliminates the string-dependencies
  enum role_name: [:human_resources, :project_manager, :editor, :admin, :user]

end

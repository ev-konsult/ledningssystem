class Role < ActiveRecord::Base
  has_many :user
  # Enum role_name maps against the integer-column of the same name in the db
  # Kinda retarded but at least it eliminates the string-dependencies
  enum role_name_id: [:human_resources, :project_manager, :editor, :admin, :user]

  def self.role_name_attributes_for_select
    role_name_ids.map do |role_name_id, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.role_name_ids.#{role_name_id}"), role_name_id]
    end
  end
end

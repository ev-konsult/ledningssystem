class Role < ActiveRecord::Base
  has_many :user
end

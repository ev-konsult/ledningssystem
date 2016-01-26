class User < ActiveRecord::Base
  validates :name,     presence: true,
                       length: { in: 4..100 },
                       uniqueness: true

  validates :password, presence: true,
                       length: { in: 6..100 }

  has_secure_password
end

class User < ActiveRecord::Base
  # Detta scope används för fuzzy search (behöver inte vara exakta sökningar)
  scope :search, -> (query) { where "lower(name) like ?", "%#{query.downcase}%" }

  validates :name,     presence: true,
                       length: { in: 4..100 },
                       uniqueness: true

  validates :password, presence: true,
                       length: { in: 6..100 }

  has_secure_password
end

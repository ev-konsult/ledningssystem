class Article < ActiveRecord::Base
  belongs_to :user

  validates :title,   presence: true,
                      length: { in: 10..255 }

  validates :body,    presence: true,
                      length: { minimum: 20 }

  # Fuzzy search for title and body
  scope :search, -> (query) { where "lower(body) like ? or lower(title) like ?", "%#{query.downcase}%", "%#{query.downcase}%" }
end

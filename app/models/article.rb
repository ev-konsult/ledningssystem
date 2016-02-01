class Article < ActiveRecord::Base
  belongs_to :user

  validates :title,   presence: true,
                      length: { in: 10..255 }

  validates :body,    presence: true,
                      length: { minimum: 20 }


end

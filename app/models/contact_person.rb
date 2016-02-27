class ContactPerson < ActiveRecord::Base
  belongs_to :user
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :full_name,    length: { in: 4..100 },
                           allow_blank: true

  validates :email,        length: { maximum: 255 },
                           format: { with: VALID_EMAIL_REGEX },
                           allow_blank: true

  validates :phone_number, length: { in: 7..15 },
                           allow_blank: true
end

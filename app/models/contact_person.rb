class ContactPerson < ActiveRecord::Base
  belongs_to :user
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :full_name,     presence: true,
                       length: { in: 4..100 }

  validates :email,    presence: true, length: { maximum: 255 },
                       format: { with: VALID_EMAIL_REGEX }

  validates :phone_number, presence: true, length: { in: 7..15 }
end

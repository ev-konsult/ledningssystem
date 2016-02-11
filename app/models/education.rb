class Education < ActiveRecord::Base
  belongs_to :user

  validates :name,     presence: true,
            length: { in: 4..100 }

  validates :school,     presence: true,
            length: { in: 4..100 }

  validates :graduation,     presence: true
end

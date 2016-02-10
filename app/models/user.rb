class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_SSN_REGEX = /\A[0-9]{6}-[0-9]{4}/i
  attr_accessor :remember_token
  has_many :articles
  has_many :educations
  has_one :contact_person
  accepts_nested_attributes_for :contact_person

  before_save { self.email = email.downcase }
  # Detta scope används för fuzzy search (behöver inte vara exakta sökningar)
  scope :search, -> (query) { where "lower(name) like ?", "%#{query.downcase}%" }

  validates :name,     presence: true,
                       length: { in: 4..100 },
                       uniqueness: true

  validates :password, presence: true,
                       length: { in: 6..100 }

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }

  validates :ssn, presence: true, format: { with: VALID_SSN_REGEX }, uniqueness: true;

  validates :phone_number, presence: true, length: { in: 7..15 }


  has_secure_password

  # Remember me token
  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # "Kommer ihåg" en användare
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # "Glömmer en användare"
  def forget
    update_attribute(:remember_digest, nil)
  end

  # Returnerar hashvärdet av strängparametern
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  # Kollar en authentication token mot hashen i databasen
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end

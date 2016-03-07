class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  VALID_SSN_REGEX = /\A[0-9]{6}-[0-9]{4}/i
  attr_accessor :remember_token
  has_and_belongs_to_many :tasks
  has_many :articles
  has_many :educations
  has_one :contact_person
  belongs_to :role

  accepts_nested_attributes_for :contact_person

  before_save { self.email = email.downcase }
  before_save { self.full_name = "#{self.first_name} #{self.last_name}" }

  # Detta scope används för fuzzy search (behöver inte vara exakta sökningar)
  scope :search, -> (query) { where "lower(user_name) like ?", "%#{query.downcase}%" }
  scope :sort, -> (condition) { order("#{condition} desc") }

  validates :user_name,      presence: true,
                             length: { in: 4..100 },
                             uniqueness: true

  validates :first_name,     length: { in: 4..100 }, allow_blank: true

  validates :last_name,      length: { in: 4..100 }, allow_blank: true

  validates :password,       presence: true,
                             length: { in: 6..100 }

  validates :email,          length: { maximum: 255 },
                             format: { with: VALID_EMAIL_REGEX },
                             uniqueness: { case_sensitive: false },
                             allow_blank: true

  validates :ssn,            format: { with: VALID_SSN_REGEX },
                             uniqueness: true,
                             allow_blank: true

  validates :phone_number,   length: { in: 7..15 },
                             allow_blank: true


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

  def admin?
    correct_role? :admin
  end

  def editor?
    correct_role? :editor
  end

  def human_resources?
    correct_role? :human_resources
  end

  def project_manager?
    correct_role? :project_manager
  end

  # Kollar en authentication token mot hashen i databasen
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  private
    def correct_role?(role_name_id)
      self.role.role_name_id == role_name_id.to_s
    end
end

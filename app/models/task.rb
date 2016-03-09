class Task < ActiveRecord::Base
  VALID_DATE_REGEX = /(\d{4})-(\d{2})-(\d{2})/i

  has_and_belongs_to_many :users, :uniq => true

  validates :start,             presence: true, format: { with: VALID_DATE_REGEX }
  validates :end,               presence: true, format: { with: VALID_DATE_REGEX }
  validates :status,            presence: true
  validates :priority,          presence: true
  validates :title,             presence: true,
                                length: { minimum: 4, maximum: 255 }
  validates :description,       presence: true,
                                length: { minimum: 20 }

  validate  :start_date_cannot_be_in_the_past
  validate  :end_date_cannot_be_before_start_date

  # Enums
  enum status:   { not_started: 0, in_progress: 1, done: 2, cancelled: 3 }
  enum priority: { low: 0, medium: 1, high: 2, critical: 3 }

  # Translating enum values to prepare them for dropdown menus
  def self.priority_attributes_for_select
    priorities.map do |priority, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.priorities.#{priority}"), priority]
    end
  end

  def self.status_attributes_for_select
    statuses.map do |status, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.status.#{status}"), status]
    end
  end

  private
    # Custom validation for dates. The strings should maybe be in some
    # language file in /locales but we ran out of time
    def start_date_cannot_be_in_the_past
      errors.add(:start, " måste vara ett framtida datum") if
        !self.start.blank? and self.start.past?
    end

    def end_date_cannot_be_before_start_date
      errors.add(:end, " får inte vara innan startdatumet") if
        !self.end.blank? and self.end < self.start
    end
end

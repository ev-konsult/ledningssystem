class Task < ActiveRecord::Base
  has_and_belongs_to_many :users

  validates :start,             presence: true
  validates :end,               presence: true
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

  def self.priority_attributes_for_select
    priorities.map do |priority, _|
      [I18n.t("active_record.attributes.#{model_name.i18n_key}.priorities.#{priority}"), priority]
    end

  end

  private
    def start_date_cannot_be_in_the_past
      errors.add(:start, "can't be in the past") if
        !self.start.blank? and self.start.past?
    end

    def end_date_cannot_be_before_start_date
      errors.add(:end, "can't be before start") if
        !self.end.blank? and self.end < self.start
    end
end


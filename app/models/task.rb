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

  # Maps the keys of the priority-enum hash to its swedish counterpart
  # check config/locales/en.yml
  # TODO: Maybe own file for swedish translation?
  def self.priority_attributes_for_select
    priorities.map do |priority, _|
      [I18n.t("activerecord.attributes.#{model_name.i18n_key}.priorities.#{priority}"), priority]
    end
  end

  private
    def start_date_cannot_be_in_the_past
      errors.add(:start, " måste vara ett framtida datum") if
        !self.start.blank? and self.start.past?
    end

    def end_date_cannot_be_before_start_date
      errors.add(:end, " får inte vara innan startdatumet") if
        !self.end.blank? and self.end < self.start
    end
end

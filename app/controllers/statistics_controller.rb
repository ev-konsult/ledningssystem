class StatisticsController < ApplicationController
  before_action :check_if_logged_in, only: [:index, :show]

  # Prepares view data for the statistics in views/statistics/index.html.erb
  # The symbols from the Task and Priority enums are replaced with swedish translations

  NOT_STARTED = "Ej påbörjad"
  STARTED     = "Påbörjad"
  DONE        = "Klar"
  CANCELLED   = "Avbryten"
  LOW         = "Låg"
  MEDIUM      = "Medel"
  HIGH        = "Hög"
  CRITICAL    = "Kritisk"

  def index
    fetch_task_hash
    fetch_priority_hash
  end

  private

    # Populates a hash used by the chartkick to generate
    # a pie-chart that shows tasks by status
    def fetch_task_hash
      @tasks = {
          NOT_STARTED.to_sym => 0,
          STARTED.to_sym => 0,
          DONE.to_sym => 0,
          CANCELLED.to_sym => 0
      }

      Task.all.each do |task|
        case task.status.to_sym
          when :not_started
            @tasks[NOT_STARTED.to_sym] += 1
          when :done
            @tasks[DONE.to_sym] += 1
          when :in_progress
            @tasks[STARTED.to_sym] += 1
          when :cancelled
            @tasks[CANCELLED.to_sym] += 1
        end
      end
    end

    # Populates a hash used by the chartkick to generate
    # a pie-chart that shows tasks by priority
    def fetch_priority_hash
      @priority = {
          LOW.to_sym => 0,
          MEDIUM.to_sym => 0,
          HIGH.to_sym => 0,
          CRITICAL.to_sym => 0
      }

      Task.all.each do |task|
        case task.priority.to_sym
          when :low
            @priority[LOW.to_sym] += 1
          when :medium
            @priority[MEDIUM.to_sym] += 1
          when :high
            @priority[HIGH.to_sym] += 1
          when :critical
            @priority[CRITICAL.to_sym] += 1
        end
      end
    end
end

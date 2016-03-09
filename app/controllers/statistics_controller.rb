class StatisticsController < ApplicationController
  before_action :check_if_logged_in, only: [:index, :show]

  # Prepares view data for the statistics in views/statistics/index.html.erb
  # The symbols from the Task and Priority enums are replaced with swedish
  # translations
  def index
    @tasks = {
      "Ej påbörjad".to_sym => 0,
      "Påbörjad".to_sym => 0,
      "Klar".to_sym => 0,
      "Avbruten".to_sym => 0
    }

    @priority = {
      "Låg".to_sym => 0,
      "Medel".to_sym => 0,
      "Hög".to_sym => 0,
      "Kritisk".to_sym => 0
    }

    Task.all.each do |task|
      case task.status.to_sym
      when :not_started
        @tasks["Ej påbörjad".to_sym] += 1
      when :done
        @tasks["Klar".to_sym] += 1
      when :in_progress
        @tasks["Påbörjad".to_sym] += 1
      when :cancelled
        @tasks["Avbruten".to_sym] += 1
      end
    end

    Task.all.each do |task|
      case task.priority.to_sym
      when :low
        @priority["Låg".to_sym] += 1
      when :medium
        @priority["Medel".to_sym] += 1
      when :high
        @priority["Hög".to_sym] += 1
      when :critical
        @priority["Kritisk".to_sym] += 1
      end
    end
  end


  def show
  end
end

class StatisticsController < ApplicationController
  def index
    @tasks = {
      not_started: 0,
      in_progress: 0,
      done: 0,
      cancelled: 0
    }

    Task.all.each do |task|
      case task.status.to_sym
      when :not_started
        @tasks[:not_started] += 1
      when :done
        @tasks[:done] += 1
      when :in_progress
        @tasks[:in_progress] += 1
      when :cancelled
        @tasks[:cancelled] += 1
      end
    end
  end


  def show
  end
end

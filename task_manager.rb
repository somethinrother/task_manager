require "csv"
require 'pathname'

class TaskManager
  @@month_map = {
    1 => 'january',
    2 => 'february',
    3 => 'march',
    4 => 'april',
    5 => 'may',
    6 => 'june',
    7 => 'july',
    8 => 'august',
    9 => 'september',
    10 => 'october',
    11 => 'november',
    12 => 'december'
  }

  def initialize
    @date = Time.now.strftime("%Y%m%d")
    @month = @@month_map[Time.now.month]
    @task_name = nil
    @task_start = nil
  end

  def begin_task
    puts 'What task would you like to start?'
    @task_start = Time.now
    @task_name = gets.chomp
  end

  def perform
    loop do
      begin_task
      puts 'Press any button to complete task, or exit to complete task then exit'
      user_input = gets.chomp
      ending_timestamp = Time.now

      task_time = ((ending_timestamp - @task_start) / 60).to_i

      filename = "./task_records/tasks_for_#{@month}.csv"

      if Pathname.new(filename).exist?
        CSV.open(filename, 'a+') do |csv|
          csv << [@task_name, task_time, @date]
        end
      else
        CSV.open(filename, 'wb') do |csv|
          csv << ['task', 'time_taken', 'date']
          csv << [@task_name, task_time, @date]
        end
      end

      break if user_input == 'exit'
    end
  end
end

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
  end

  def perform
    loop do
      puts 'What task would you like to start?'
      starting_timestamp = Time.now
      task = gets.chomp
      puts 'Press any button to complete task, or exit to complete task then exit'
      user_input = gets.chomp
      ending_timestamp = Time.now

      task_time = ((ending_timestamp - starting_timestamp) / 60).to_i

      filename = "./task_records/tasks_for_#{@month}.csv"

      if Pathname.new(filename).exist?
        CSV.open(filename, 'a+') do |csv|
          csv << [task, task_time, @date]
        end
      else
        CSV.open(filename, 'wb') do |csv|
          csv << ['task', 'time_taken', 'date']
          csv << [task, task_time, @date]
        end
      end

      break if user_input == 'exit'
    end
  end
end

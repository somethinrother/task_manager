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
    @filename = "./task_records/tasks_for_#{@month}.csv"
    @task_name = nil
    @task_start = nil
    @task_end = nil
    @user_input = nil
  end

  def begin_task
    puts 'What task would you like to start?'
    @task_start = Time.now
    @task_name = gets.chomp
  end

  def wait_for_end_of_task
    puts 'Press any button to complete task, or exit to complete task then exit'
    @user_input = gets.chomp
    @task_end = Time.now
  end

  def task_duration
    ((@task_end - @task_start) / 60).to_i
  end

  def save_task
    if Pathname.new(@filename).exist?
      CSV.open(@filename, 'a+') do |csv|
        csv << [@task_name, task_duration, @date]
      end
    else
      CSV.open(@filename, 'wb') do |csv|
        csv << ['task', 'time_taken', 'date']
        csv << [@task_name, task_duration, @date]
      end
    end
  end

  def perform
    loop do
      begin_task
      wait_for_end_of_task
      save_task

      break if @user_input == 'exit'
    end
  end
end

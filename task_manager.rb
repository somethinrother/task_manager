require "csv"
require 'pathname'

date = Time.now.strftime("%Y%m%d")

loop do
  puts 'What task would you like to start?'
  starting_timestamp = Time.now
  task = gets.chomp
  puts 'Press any button to complete task, or exit to complete task then exit'
  user_input = gets.chomp
  ending_timestamp = Time.now

  task_time = ((ending_timestamp - starting_timestamp) / 60).to_i

  filename = "./task_records/tasks_for_#{date}.csv"

  if Pathname.new(filename).exist?
    CSV.open(filename, 'a+') do |csv|
      csv << [task, task_time, date]
    end
  else
    CSV.open(filename, 'wb') do |csv|
      csv << ['task', 'time_taken', 'date']
      csv << [task, task_time, date]
    end
  end

  break if user_input == 'exit'
end

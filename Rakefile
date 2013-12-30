#!/usr/bin/env rake

task :default => :spec

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)


namespace :temperature do

  # Require everything in the lib directory.
  Dir["./lib/*.rb"].each {|file| require file }

  # Load the credentials file.
  credentials = YAML.load(File.read(File.expand_path('../config/credentials.yml', __FILE__)))

  # Get the Twine information.
  twines = credentials['twines']

  # Get the WOEID
  woeid = credentials['woeid']

  # Get the Google Authentication Credentials
  google_username = credentials['google_username']
  google_password = credentials['google_password']
  google_spreadsheet_key = credentials['google_spreadsheet_key']
  

  desc "Gets the current temperatures"
  task :current do
    for twine in twines do
      selected_twine = Twine.new(twine[1])
      current_temp = selected_twine.status(:temperature)
      puts "#{selected_twine.name}: #{current_temp}"
      puts "==="
    end
    outside_temp = OutsideTemp.new(woeid)
    puts "Outside Temperature: #{outside_temp.current}"
    puts "Outside High: #{outside_temp.high}"
    puts "Outside Low: #{outside_temp.low}"
  end

  desc "Records the current temperature"
  task :record do
    for twine in twines do
      selected_twine = Twine.new(twine[1])
      current_temp = selected_twine.status(:temperature)
    end
    outside_temp = OutsideTemp.new(woeid)
    puts "#{current_temp}/#{outside_temp.current} @ #{Time.now.getlocal('-05:00').strftime('%m/%d/%Y %l:%M %p')}"
  end

  desc "Outputs all the settings"
  task :settings do
    puts "==="
    puts "Number of Twines: #{twines.length}"
    for twine in twines do
      puts "==="
      puts "Twine Name: #{twine[1]['twine_name']}"
      puts "Twine Id: #{twine[1]['twine_id']}"
      puts "Twine Access Key: #{twine[1]['twine_access_key']}"
      puts "==="
    end
    puts "WOEID: #{woeid}"
    puts "==="
    puts "Google Username: #{google_username}"
    puts "Google Password: #{google_password.to_s.gsub(/./,'*')}"
    puts "Google Spreadsheet Key: #{google_spreadsheet_key}"
    puts "==="
  end

end
require 'yaml'

Dir["./lib/*.rb"].each {|file| require file }

CREDENTIALS = YAML.load(File.read(File.expand_path('../config/credentials.yml', __FILE__)))

twine = Twine.new(CREDENTIALS['twine_id'],CREDENTIALS['twine_access_key'])
outside = OutsideTemp.current(CREDENTIALS['woeid'])
reading = Reading.new(CREDENTIALS['google_username'],CREDENTIALS['google_password'],CREDENTIALS['google_spreadsheet_key'])

reading.record(Time.now.getlocal("-05:00").strftime("%m/%d/%Y %l:%M %p"),outside,[twine.status(:temperature)])

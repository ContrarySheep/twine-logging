# Load the credentials file
credentials = YAML.load(File.read(File.expand_path('../config/credentials.yml', __FILE__)))

# Load DSL and Setup Up Stages
require 'capistrano/setup'
# require 'capistrano/console'

# Ignore I18n variables
I18n.enforce_available_locales = false

# Set the stage and the server infromation
set :stage, :rpi
server credentials['rpi_address'], user: credentials['rpi_username'], password: credentials['rpi_password'], roles: [:rpi]

# Import the custom tasks from the deploy directory
Dir.glob('deploy/*.cap').each { |r| import r }
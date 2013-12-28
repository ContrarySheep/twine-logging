# Require the gems needed for testing.
require 'rubygems'
require 'rspec'
require 'net/http'
require 'yaml'

# Require all files in the lib directory.
Dir["../../lib/*.rb"].each {|file| require file }

# Load the credentials from the config directory.
CREDENTIALS = YAML.load(File.read(File.expand_path('../../config/credentials.yml', __FILE__)))
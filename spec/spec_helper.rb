require 'rubygems'
require 'rspec'
require 'net/http'
require 'yaml'

Dir["../../lib/*.rb"].each {|file| require file }

CREDENTIALS = YAML.load(File.read(File.expand_path('../../config/credentials.yml', __FILE__)))
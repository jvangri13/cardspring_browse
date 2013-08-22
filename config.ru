require 'rubygems'
require 'bundler'
Bundler.setup

require 'cardspring_browse'

use Rack::ContentLength

config_path = File.expand_path("../config/cardspring.yml", __FILE__)
app =  CardspringBrowse::Application.new(config_path)

run app

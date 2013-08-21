require 'rubygems'
require 'bundler'
Bundler.setup

require 'cardspring_browse'

config_path = File.expand_path("../config/cardspring.yml", __FILE__)
app =  CardspringBrowse::Application.new(config_path)

run app

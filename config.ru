require 'rubygems'
require 'bundler'
Bundler.setup

require 'cardspring_browse'

use Rack::Config do |env|
  env['rack.errors'] = $>
end
use Rack::CommonLogger

use CardspringBrowse::Application, File.expand_path("../config/cardspring.yml", __FILE__)

run proc { |env| 404 }

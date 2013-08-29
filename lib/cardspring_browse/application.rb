require 'sinatra/base'
require_relative 'app/cardspring'

module CardspringBrowse
  class Application < Sinatra::Base

    enable :method_override
    enable :config_file

    PROPERTY_NAME = 'cardspring_browse.config_file'
    use Rack::Config do |env|
      env[PROPERTY_NAME] = settings.config_file
    end

    use CardspringBrowse::App::Cardspring

    def initialize(app, config_file = __FILE__)
      super(app)
      settings.config_file = config_file
    end

    get "/" do
      redirect to("/v1")
    end

  end
end
